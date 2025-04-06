import 'dart:convert';

import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/file_manager.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getFileExcel/get_file_excel_cubit.dart';

class FileExcel extends StatelessWidget {
  final Pages pageData;
  final String lang;

  const FileExcel({
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
            String massage=await convertJsonToExcel(context,jsonString, lang); // لاستخدام الأسماء العربية
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
                  S.of(context).exporting_excel_file,
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

  Future<String> convertJsonToExcel(BuildContext context,String jsonString, String language) async {

    if (!await requestStoragePermission()) {

      return S.of(context).permission_denied;
    }
    var jsonData = jsonDecode(jsonString);

    List<dynamic> columnList = jsonData['columnList'];
    List<dynamic> dataList = jsonData['dataList'];

    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // إنشاء خريطة تربط كل ColumnName باسم العمود المناسب بناءً على اللغة المختارة
    Map<String, String> columnHeaders = {
      for (var col in columnList)
        if(col['visible']==true)
        col['ColumnName']: language == AppStrings.arLangKey ? col['arColumnLabel'] : col['enColumnLabel']
    };

    // استخراج أسماء الأعمدة بالترتيب
    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // إضافة العناوين إلى أول صف في Excel
    sheet.appendRow(columnLabels.map((label) => TextCellValue(label)).toList());

    // إضافة البيانات إلى الجدول
    for (var item in dataList) {
      sheet.appendRow(columnKeys.map((key) => TextCellValue(item[key]?.toString() ?? '')).toList());
    }

    // حفظ الملف
    // Directory? dir = await getApplicationDocumentsDirectory();
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName=lang==AppStrings.arLangKey?pageData.nameAr:pageData.nameEn;
    String path = "${dir.path}/$fileName.xlsx";
    if(await File(path).exists()){
      File(path).delete();
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
    }else{
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
    }

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
