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
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/file_manager.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getFileExcel/get_file_excel_cubit.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

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
            String massage=await convertExcelToPdf(context,jsonString, lang); // لاستخدام الأسماء العربية
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

  /*Future <String> convertJsonToPdf(BuildContext context,String jsonString, String language) async {
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
  }*/
/*

  Future<String> convertJsonToPdf(BuildContext context, String jsonString, String language) async {
    if (!await requestStoragePermission()) {
      return S.of(context).permission_denied;
    }

    var jsonData = jsonDecode(jsonString);
    List<dynamic> columnList = jsonData['columnList'];
    List<dynamic> dataList = jsonData['dataList'];

    final pdf = pw.Document();
    final fontData = await rootBundle.load(AppAssets.font);
    final ttf = pw.Font.ttf(fontData);

    // إنشاء خريطة بأسماء الأعمدة بناءً على اللغة المختارة
    Map<String, String> columnHeaders = {
      for (var col in columnList)
        col['ColumnName']: language == AppStrings.arLangKey ? col['arColumnLabel'] : col['enColumnLabel']
    };

    // استخراج أسماء الأعمدة
    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // تقسيم الأعمدة إلى مجموعات لا تتجاوز 7 أعمدة لكل مجموعة
    int maxColumnsPerPage = 7;
    int totalColumns = columnKeys.length;
    List<List<String>> columnGroups = [];
    List<List<String>> columnLabelGroups = [];

    for (int i = 0; i < totalColumns; i += maxColumnsPerPage) {
      int end = (i + maxColumnsPerPage < totalColumns) ? i + maxColumnsPerPage : totalColumns;
      columnGroups.add(columnKeys.sublist(i, end));
      columnLabelGroups.add(columnLabels.sublist(i, end));
    }

    int maxRowsPerPage = 20; // عدد الصفوف لكل صفحة (يمكن تعديله حسب الحاجة)

    for (int groupIndex = 0; groupIndex < columnGroups.length; groupIndex++) {
      List<String> currentColumnKeys = columnGroups[groupIndex];
      List<String> currentColumnLabels = columnLabelGroups[groupIndex];

      for (int i = 0; i < dataList.length; i += maxRowsPerPage) {
        int end = (i + maxRowsPerPage < dataList.length) ? i + maxRowsPerPage : dataList.length;
        List<List<String>> tableData = [
          currentColumnLabels, // إضافة عناوين الأعمدة
          ...dataList.sublist(i, end).map(
                (item) => currentColumnKeys.map((key) => item[key]?.toString() ?? '').toList(),
          ),
        ];

        // إضافة الصفحة إلى ملف PDF
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.TableHelper.fromTextArray(
                headers: tableData.first,
                data: tableData.sublist(1),
                border: pw.TableBorder.all(),
                cellAlignment: pw.Alignment.centerLeft,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                cellStyle: pw.TextStyle(fontSize: 12, font: ttf),
              );
            },
          ),
        );
      }
    }

    // حفظ الملف
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName = language == AppStrings.arLangKey ? pageData.nameAr : pageData.nameEn;
    String path = "${dir.path}/$fileName.pdf";
    File file = File(path);
    await file.writeAsBytes(await pdf.save());

    openFile(path);
    return "${S.of(context).file_saved_in}\n$path";
  }
*/
/*

  Future<String> convertJsonToPdf(BuildContext context, String jsonString, String language) async {
    if (!await requestStoragePermission()) {
      return S.of(context).permission_denied;
    }

    var jsonData = jsonDecode(jsonString);
    List<dynamic> columnList = jsonData['columnList'];
    List<dynamic> dataList = jsonData['dataList'];

    final pdf = pw.Document();
    final fontData = await rootBundle.load(AppAssets.font);
    final ttf = pw.Font.ttf(fontData);

    // إنشاء خريطة بأسماء الأعمدة بناءً على اللغة المختارة
    Map<String, String> columnHeaders = {
      for (var col in columnList)
        col['ColumnName']: language == AppStrings.arLangKey ? col['arColumnLabel'] : col['enColumnLabel']
    };

    // استخراج أسماء الأعمدة
    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // تقسيم الأعمدة إلى مجموعات لا تتجاوز 7 أعمدة لكل مجموعة
    int maxColumnsPerPage = 7;
    int totalColumns = columnKeys.length;
    List<List<String>> columnGroups = [];
    List<List<String>> columnLabelGroups = [];

    for (int i = 0; i < totalColumns; i += maxColumnsPerPage) {
      int end = (i + maxColumnsPerPage < totalColumns) ? i + maxColumnsPerPage : totalColumns;
      columnGroups.add(columnKeys.sublist(i, end));
      columnLabelGroups.add(columnLabels.sublist(i, end));
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          List<pw.Widget> pages = [];

          for (int groupIndex = 0; groupIndex < columnGroups.length; groupIndex++) {
            List<String> currentColumnKeys = columnGroups[groupIndex];
            List<String> currentColumnLabels = columnLabelGroups[groupIndex];

            List<List<String>> tableData = [
              currentColumnLabels, // إضافة عناوين الأعمدة
              ...dataList.map(
                    (item) => currentColumnKeys.map((key) => item[key]?.toString() ?? '').toList(),
              ),
            ];

            pages.add(
              pw.TableHelper.fromTextArray(
                headers: tableData.first,
                data: tableData.sublist(1),
                border: pw.TableBorder.all(),
                cellAlignment: pw.Alignment.centerLeft,
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
                cellStyle: pw.TextStyle(fontSize: 12, font: ttf),
              ),
            );

            pages.add(pw.SizedBox(height: 20)); // إضافة مسافة بين الجداول
          }

          return pages;
        },
      ),
    );

    // حفظ الملف
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName = language == AppStrings.arLangKey ? pageData.nameAr : pageData.nameEn;
    String path = "${dir.path}/$fileName.pdf";
    File file = File(path);
    await file.writeAsBytes(await pdf.save());

    openFile(path);
    return "${S.of(context).file_saved_in}\n$path";
  }
*/

//   Future<String> convertJsonToPdf(BuildContext context, String jsonString, String language) async {
//     if (!await requestStoragePermission()) {
//       return S.of(context).permission_denied;
//     }
//
//     var jsonData = jsonDecode(jsonString);
//     List<dynamic> columnList = jsonData['columnList'];
//     List<dynamic> dataList = jsonData['dataList'];
//
//     final pdf = pw.Document();
//     final fontData = await rootBundle.load(AppAssets.font);
//     final ttf = pw.Font.ttf(fontData);
//
//     bool isArabic = language == AppStrings.arLangKey;
//
//     // إنشاء خريطة بأسماء الأعمدة بناءً على اللغة المختارة
//     Map<String, String> columnHeaders = {
//       for (var col in columnList)
//         col['ColumnName']: isArabic ? col['arColumnLabel'] : col['enColumnLabel']
//     };
//
//     // استخراج أسماء الأعمدة
//     List<String> columnKeys = columnHeaders.keys.toList();
//     List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();
//
//     // تحويل النصوص إلى RTL إذا كانت باللغة العربية
//     if (isArabic) {
//       columnLabels = columnLabels.map((label) => _fixArabicText(label)).toList();
//     }
//
//     // تقسيم الأعمدة إلى مجموعات لا تتجاوز 7 أعمدة لكل مجموعة
//     int maxColumnsPerPage = 7;
//     int totalColumns = columnKeys.length;
//     List<List<String>> columnGroups = [];
//     List<List<String>> columnLabelGroups = [];
//
//     for (int i = 0; i < totalColumns; i += maxColumnsPerPage) {
//       int end = (i + maxColumnsPerPage < totalColumns) ? i + maxColumnsPerPage : totalColumns;
//       columnGroups.add(columnKeys.sublist(i, end));
//       columnLabelGroups.add(columnLabels.sublist(i, end));
//     }
//
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         textDirection: isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr, // تعيين اتجاه النص
//         build: (pw.Context context) {
//           List<pw.Widget> pages = [];
//
//           for (int groupIndex = 0; groupIndex < columnGroups.length; groupIndex++) {
//             List<String> currentColumnKeys = columnGroups[groupIndex];
//             List<String> currentColumnLabels = columnLabelGroups[groupIndex];
//
//             List<List<String>> tableData = [
//               currentColumnLabels, // إضافة عناوين الأعمدة
//               ...dataList.map((item) {
//                 List<String> row = currentColumnKeys.map((key) {
//                   String text = item[key]?.toString() ?? '';
//                   return  text;
//                   // return isArabic ? _fixArabicText(text) : text;
//                 }).toList();
//                 return row;
//               }),
//             ];
//
//             pages.add(
//               pw.TableHelper.fromTextArray(
//                 headers: tableData.first,
//                 data: tableData.sublist(1),
//                 border: pw.TableBorder.all(),
//                 cellAlignment: pw.Alignment.centerLeft,
//                 headerStyle: pw.TextStyle(
//                   fontWeight: pw.FontWeight.bold,
//                   font: ttf,
//                 ),
//                 cellStyle: pw.TextStyle(
//                   fontSize: 12,
//                   font: ttf,
//                 ),
//               ),
//             );
//
//             pages.add(pw.SizedBox(height: 20)); // إضافة مسافة بين الجداول
//           }
//
//           return pages;
//         },
//       ),
//     );
//
//     // حفظ الملف
//     Directory? dir = await FileManager.getAppStorageDirectory();
//     String fileName = isArabic ? pageData.nameAr : pageData.nameEn;
//     String path = "${dir.path}/$fileName.pdf";
//     File file = File(path);
//     await file.writeAsBytes(await pdf.save());
//
//     openFile(path);
//     return "${S.of(context).file_saved_in}\n$path";
//   }
//
// // دالة لمعالجة النص العربي لمنع عرضه بالمقلوب
//   String _fixArabicText(String text) {
//     return text.split('').reversed.join(); // عكس النص ليظهر بشكل صحيح في PDF
//   }
//
//
//   Future<bool> requestStoragePermission() async {
//     var status = await Permission.storage.status;
//
//     if (!status.isGranted) {
//       status = await Permission.storage.request();
//     }
//
//     if (await Permission.manageExternalStorage.request().isGranted) {
//       return true;
//     }
//
//     return status.isGranted;
//   }
//   Future<void> openFile(String filePath) async {
//     await OpenFile.open(filePath);
//   }



  Future<String> convertExcelToPdf(BuildContext context, String jsonString, String language) async {
    if (!await requestStoragePermission()) {
      return S.of(context).permission_denied;
    }

    var jsonData = jsonDecode(jsonString);
    List<dynamic> columnList = jsonData['columnList'];
    List<dynamic> dataList = jsonData['dataList'];

    // final xls.Workbook workbook = xls.Workbook();
    // final xls.Worksheet sheet = workbook.worksheets[0];

    Map<String, String> columnHeaders = {
      for (var col in columnList)
        if(col['visible']==true)
        col['ColumnName']: language == 'ar' ? col['arColumnLabel'] : col['enColumnLabel']
    };

    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // for (int i = 0; i < columnLabels.length; i++) {
    //   sheet.getRangeByIndex(1, i + 1).setText(columnLabels[i]);
    // }

    // for (int row = 0; row < dataList.length; row++) {
    //   for (int col = 0; col < columnKeys.length; col++) {
    //     sheet.getRangeByIndex(row + 2, col + 1).setText(dataList[row][columnKeys[col]]?.toString() ?? '');
    //   }
    // }

    // final List<int> excelBytes = workbook.saveAsStream();
    // workbook.dispose();

    final PdfDocument pdfDoc = PdfDocument();
    final PdfGrid pdfGrid = PdfGrid();
    pdfGrid.columns.add(count: columnLabels.length);

    // 🟢 تحميل الخط العربي
    final ByteData fontData = await rootBundle.load(AppAssets.font);
    final Uint8List fontBytes = fontData.buffer.asUint8List();
    final PdfFont arabicFont = PdfTrueTypeFont(fontBytes, 12);

    // 🟢 تطبيق الخط على الجدول
    pdfGrid.style = PdfGridStyle(font: arabicFont);

    // 🟢 إعداد الهيدر
    final PdfGridRow headerRow = pdfGrid.headers.add(1)[0];
    for (int i = 0; i < columnLabels.length; i++) {
      headerRow.cells[i].stringFormat = PdfStringFormat(
        textDirection: PdfTextDirection.rightToLeft,
        alignment: PdfTextAlignment.center,
      );
      headerRow.cells[i].value = columnLabels[i];
    }

    // 🟢 إدخال البيانات
    for (var item in dataList) {
      final PdfGridRow row = pdfGrid.rows.add();
      for (int i = 0; i < columnKeys.length; i++) {
        row.cells[i].stringFormat = PdfStringFormat(
          textDirection: PdfTextDirection.rightToLeft,
          alignment: PdfTextAlignment.center,
        );
        row.cells[i].value = item[columnKeys[i]]?.toString() ?? '';
      }
    }

    // 🟢 رسم الجدول مع خاصية التقسيم الآلي للصفحات
    pdfGrid.draw(
      page: pdfDoc.pages.add(),
      bounds: const Rect.fromLTWH(0, 0, 500, 700),
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    final List<int> pdfBytes = await pdfDoc.save();
    pdfDoc.dispose();

    // 🟢 حفظ الملف
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName = language == AppStrings.arLangKey ? pageData.nameAr : pageData.nameEn;
    String path = "${dir.path}/$fileName.pdf";
    if(await File(path).exists()){
      File(path).delete();
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(pdfBytes);
    }else{
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(pdfBytes);
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