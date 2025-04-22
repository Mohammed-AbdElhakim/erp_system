import 'package:dio/dio.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/core/utils/app_assets.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/file_manager.dart';
import '../../../../core/utils/methods.dart';
import '../../../../generated/l10n.dart';
import '../helper/SharedPreferences/pref.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../utils/api_service.dart';

class FilePdfByData extends StatelessWidget {
  final Pages pageData;
  final Map<String, dynamic> data;
  final int tabIndex;
  final String link;
  final String lang;

  const FilePdfByData({
    super.key,
    required this.pageData,
    required this.lang,
    required this.data,
    required this.tabIndex,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: fetchData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).exporting_pdf_file,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.blueLight),
                ),
                const SizedBox(height: 8),
                const CustomLoadingWidget()
              ],
            );
          } else if (snapshot.hasError) {
            return CustomErrorMassage(
              errorMassage: '${snapshot.error}',
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Navigator.pop(context);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showSnackBar(
                context: context,
                message: snapshot.data.toString(),
              );
            });

            return const SizedBox();
          } else {
            return const SizedBox();
          }
        });
  }

  Future<String> convertExcelToPdf(
      BuildContext context, List<dynamic> header, List<dynamic> responseData, String language) async {
    if (!await requestStoragePermission()) {
      return S.of(context).permission_denied;
    }

    // var jsonData = jsonDecode(jsonString);

    List<dynamic> columnList = header;
    List<dynamic> dataList = responseData;
    List<String> columnKeys;
    List<String> columnLabels;
    // final xls.Workbook workbook = xls.Workbook();
    // final xls.Worksheet sheet = workbook.worksheets[0];

    if (columnList.length >= 10) {
      Map<String, String> columnHeaders = {
        for (var col in columnList.sublist(0, 10))
          col['ColumnName']: language == 'ar' ? col['arColumnLabel'] : col['enColumnLabel']
      };
      columnKeys = columnHeaders.keys.toList();
      columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();
    } else {
      Map<String, String> columnHeaders = {
        for (var col in columnList) col['ColumnName']: language == 'ar' ? col['arColumnLabel'] : col['enColumnLabel']
      };
      columnKeys = columnHeaders.keys.toList();
      columnLabels = columnKeys.map((key) => columnHeaders[key] ?? key).toList();
    }

    columnKeys = columnKeys.reversed.toList();
    columnLabels = columnLabels.reversed.toList();

    final PdfDocument pdfDoc = PdfDocument();
    final PdfGrid pdfGrid = PdfGrid();
    pdfGrid.columns.add(count: columnLabels.length);

    // 🟢 تحميل الخط العربي
    final ByteData fontData = await rootBundle.load(AppAssets.font);
    final Uint8List fontBytes = fontData.buffer.asUint8List();
    final PdfFont arabicFont = PdfTrueTypeFont(fontBytes, 10);

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
      // bounds: const Rect.fromLTWH(0, 0, 500, 700),
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    final List<int> pdfBytes = await pdfDoc.save();
    pdfDoc.dispose();

    // 🟢 حفظ الملف
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName = lang == AppStrings.arLangKey ? "${pageData.nameAr} - $tabIndex" : "${pageData.nameEn} - $tabIndex";
    String path = "${dir.path}/$fileName.pdf";
    if (await File(path).exists()) {
      File(path).delete();
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(pdfBytes);
    } else {
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

  Future<String> fetchData(BuildContext context) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      data["limit"] = 0;
      // var rrr = jsonEncode(data);
      Map<String, dynamic> response = await ApiService(Dio()).post(
        endPoint: "web/$link/getDataGlobal",
        data: data,
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<dynamic> header = await ApiService(Dio()).get(
        endPoint: "web/Structure/getListSetups/${data['listName']}",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<dynamic> headerFiltered = header.where((item) {
        return item['visible'] == true &&
            // item['MobileVisable'] == true &&
            item['Cvisable'] == true;
      }).toList();
      // String jsonString = jsonEncode();
      String massage = await convertExcelToPdf(context, headerFiltered, response['dynamicList'], lang);
      return massage;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
