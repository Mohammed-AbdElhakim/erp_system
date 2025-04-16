import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/file_manager.dart';
import '../../../../generated/l10n.dart';
import '../helper/SharedPreferences/pref.dart';
import '../utils/api_service.dart';
import '../utils/methods.dart';

class FileExcelByData extends StatelessWidget {
  final Pages pageData;
  final Map<String, dynamic> data;
  final int tabIndex;
  final String link;
  final String lang;

  const FileExcelByData({
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
            print("========= waiting ============");
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
          } else if (snapshot.hasError) {
            print("========= Error ============");
            return CustomErrorMassage(
              errorMassage: 'Error: ${snapshot.error}',
            );
            // return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            print("========= Done ============");
            Navigator.pop(context);
            SchedulerBinding.instance.addPostFrameCallback((_) {
              showSnackBar(
                context: context,
                message: snapshot.data.toString(),
              );
            });

            return SizedBox();
          } else {
            print("========= wwwwwwww ============");
            return SizedBox();
          }
        });
  }

  Future<String> convertJsonToExcel(BuildContext context, List<dynamic> header,
      List<dynamic> responseData, String language) async {
    print("=================== convertJsonToExcel  =============");
    if (!await requestStoragePermission()) {
      return S.of(context).permission_denied;
    }
    // var jsonData = jsonDecode(jsonString);

    List<dynamic> columnList = header;
    List<dynamic> dataList = responseData;

    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // إنشاء خريطة تربط كل ColumnName باسم العمود المناسب بناءً على اللغة المختارة
    Map<String, String> columnHeaders = {
      for (var col in columnList)
        if (col['visible'] == true)
          col['ColumnName']: language == AppStrings.arLangKey
              ? col['arColumnLabel']
              : col['enColumnLabel']
    };

    // استخراج أسماء الأعمدة بالترتيب
    List<String> columnKeys = columnHeaders.keys.toList();
    List<String> columnLabels =
        columnKeys.map((key) => columnHeaders[key] ?? key).toList();

    // إضافة العناوين إلى أول صف في Excel
    sheet.appendRow(columnLabels.map((label) => TextCellValue(label)).toList());

    // إضافة البيانات إلى الجدول
    for (var item in dataList) {
      sheet.appendRow(columnKeys
          .map((key) => TextCellValue(item[key]?.toString() ?? ''))
          .toList());
    }

    // حفظ الملف
    // Directory? dir = await getApplicationDocumentsDirectory();
    Directory? dir = await FileManager.getAppStorageDirectory();
    String fileName = lang == AppStrings.arLangKey
        ? "${pageData.nameAr} - $tabIndex"
        : "${pageData.nameEn} - $tabIndex";
    String path = "${dir.path}/$fileName.xlsx";
    if (await File(path).exists()) {
      File(path).delete();
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
    } else {
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

  Future<String> fetchData(BuildContext context) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      data["limit"] = 0;
      var rrr = jsonEncode(data);
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
      // String jsonString = jsonEncode();
      String massage = await convertJsonToExcel(
          context, header, response['dynamicList'], lang);
      return massage;
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
