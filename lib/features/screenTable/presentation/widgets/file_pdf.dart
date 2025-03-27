import 'dart:convert';

import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/core/utils/app_assets.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/file_manager.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getFileExcel/get_file_excel_cubit.dart';

class FilePdf extends StatelessWidget {
  final Pages pageData;
  final String lang;

  const FilePdf({
    super.key, required this.pageData, required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetFileExcelCubit(
        getIt.get<ScreenRepoImpl>(),
      )
        ..getFileExcel(pageData: pageData),
      child: BlocConsumer<GetFileExcelCubit, GetFileExcelState>(
        listener: (BuildContext context, GetFileExcelState state) async{
          if(state is GetFileExcelSuccess){
            String jsonString = jsonEncode(state.screenModel.toJson()); // ضع هنا نص JSON المأخوذ من API أو ملف
            String massage=await convertJsonToPdf(context,jsonString, lang); // لاستخدام الأسماء العربية
              Navigator.pop(context);
              showSnackBar(context: context,message: massage,);

          }
        },
        builder: (context, state) {
          if(state is GetFileExcelFailure){
            return CustomErrorMassage(errorMassage: state.errorMassage);
          }else{
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).exporting_pdf_file,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blueLight),
                ),
                const SizedBox(height: 8),
                const CustomLoadingWidget()
              ],
            );
          }
        },
      ),
    );
  }

  Future <String> convertJsonToPdf(BuildContext context,String jsonString, String language) async {
    if (!await requestStoragePermission()) {

      return S.of(context).permission_denied;
    }
    var jsonData = jsonDecode(jsonString);

    List<dynamic> columnList = jsonData['columnList'];
    List<dynamic> dataList = jsonData['dataList'];

    final pdf = pw.Document();
    final fontData = await rootBundle.load(AppAssets.font);
    final ttf = pw.Font.ttf(fontData);

    // إنشاء خريطة تربط كل ColumnName باسم العمود المناسب بناءً على اللغة المختارة
    Map<String, String> columnHeaders = {
      for (var col in columnList)
        col['ColumnName']: language == AppStrings.arLangKey ? col['arColumnLabel'] : col['enColumnLabel']
    };

    // استخراج أسماء الأعمدة بالترتيب
    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // إنشاء محتوى الجدول
    List<List<String>> tableData = [
      columnLabels, // إضافة عناوين الأعمدة كأول صف
      ...dataList.map((item) => columnKeys.map((key) => item[key]?.toString() ?? '').toList()),
    ];

    // إنشاء الجدول في PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.TableHelper.fromTextArray(
            headers: tableData.first, // عناوين الأعمدة
            data: tableData.sublist(1), // بيانات الصفوف
            border: pw.TableBorder.all(),
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold,font: ttf),
            cellStyle:  pw.TextStyle(fontSize: 12,font: ttf),
          );
        },
      ),
    );

    // حفظ الملف
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName=lang==AppStrings.arLangKey?pageData.nameAr:pageData.nameEn;
    String path = "${dir.path}/$fileName.pdf";
    File file = File(path);
    await file.writeAsBytes(await pdf.save());

    openFile(path);
    return "${S.of(context).file_saved_in}\n$path";
  }
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (await Permission.manageExternalStorage.request().isGranted) {
      return true;
    }

    return status.isGranted;
  }
  Future<void> openFile(String filePath) async {
    await OpenFile.open(filePath);
  }
}