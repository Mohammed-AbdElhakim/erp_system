import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/features/screenTable/data/models/permission_model.dart';
import 'package:erp_system/features/screenTable/data/repositories/screen_repo.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/column_data_model.dart';

class ScreenRepoImpl implements ScreenRepo {
  final ApiService apiService;

  ScreenRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ScreenModel>> getTable(Pages page) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.post(
        endPoint: "home/getGeneralTable",
        data: {
          "pageId": 328,
          "employee": false,
          "isdesc": false,
          "limit": 1,
          "offset": 0,
          "orderby": "",
          "statment": "",
          "selectcolumns": ""
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      // Map<String, dynamic> data = {
      //   "columList": [
      //     {
      //       "id": 131750,
      //       "ListName": "offerstates",
      //       "ColumnName": "Id",
      //       "enColumnLabel": " English Name ",
      //       "arColumnLabel": "ID",
      //       "InsertVisable": false,
      //       "InsertType": "number",
      //       "userID": 4121,
      //       "ListID": 16844,
      //       "sort": 3,
      //       "visible": false,
      //       "Cvisable": false,
      //       "validation": "required",
      //       "isKey": false,
      //       "IsRquired": false,
      //       "SearchName": "Id",
      //       "IsTotal": false,
      //       "InsertDefult": true,
      //       "VisableDefult": true,
      //       "Width": 140,
      //       "MobileVisable": true,
      //       "ComID": 1,
      //       "MasterInsertVisible": false
      //     },
      //     {
      //       "id": 131749,
      //       "ListName": "offerstates",
      //       "ColumnName": "EnName",
      //       "enColumnLabel": " English Name ",
      //       "arColumnLabel": "الاسم بالانجليزية",
      //       "InsertVisable": true,
      //       "InsertType": "text",
      //       "userID": 4121,
      //       "ListID": 16843,
      //       "sort": 1,
      //       "visible": true,
      //       "Cvisable": true,
      //       "validation": "required",
      //       "isKey": false,
      //       "IsRquired": false,
      //       "SearchName": "EnName",
      //       "IsTotal": false,
      //       "InsertDefult": true,
      //       "VisableDefult": true,
      //       "Width": 140,
      //       "MobileVisable": true,
      //       "ComID": 1,
      //       "MasterInsertVisible": true
      //     },
      //     {
      //       "id": 131748,
      //       "ListName": "offerstates",
      //       "ColumnName": "ArName",
      //       "enColumnLabel": " Arabic Name ",
      //       "arColumnLabel": "الاسم بالعربية",
      //       "InsertVisable": true,
      //       "InsertType": "text",
      //       "userID": 4121,
      //       "ListID": 16842,
      //       "sort": 2,
      //       "visible": true,
      //       "Cvisable": true,
      //       "validation": "required",
      //       "isKey": false,
      //       "IsRquired": false,
      //       "SearchName": "ArName",
      //       "IsTotal": false,
      //       "InsertDefult": true,
      //       "VisableDefult": true,
      //       "Width": 140,
      //       "MobileVisable": true,
      //       "ComID": 1,
      //       "MasterInsertVisible": true
      //     },
      //     {
      //       "id": 131757,
      //       "ListName": "offerstates",
      //       "ColumnName": "Color",
      //       "enColumnLabel": "Color",
      //       "arColumnLabel": "اللون",
      //       "InsertVisable": true,
      //       "InsertType": "color",
      //       "userID": 4121,
      //       "ListID": 16863,
      //       "sort": 4,
      //       "visible": true,
      //       "Cvisable": true,
      //       "validation": "required",
      //       "isKey": false,
      //       "IsRquired": false,
      //       "SearchName": "Color",
      //       "IsTotal": false,
      //       "InsertDefult": true,
      //       "VisableDefult": true,
      //       "Width": 140,
      //       "MobileVisable": true,
      //       "ComID": 1,
      //       "MasterInsertVisible": true
      //     },
      //   ],
      //   "dataList": {
      //     "dynamicList": [
      //       {
      //         "Id": 1,
      //         "ArName": "DemoDemoDemoDemo DemoDemo DemoDemo Demo Demo",
      //         "EnName": "Demo",
      //         "Color": "#56e907",
      //       },
      //       {
      //         "Id": 2,
      //         "ArName": "waiting",
      //         "EnName": "waiting",
      //         "Color": "#0bf4ae",
      //       },
      //       {
      //         "Id": 3,
      //         "ArName": "open",
      //         "EnName": "open",
      //         "Color": "#10f4f0",
      //       },
      //       {
      //         "Id": 4,
      //         "ArName": "Demo",
      //         "EnName": "Demo",
      //         "Color": "#56e907",
      //       },
      //       {
      //         "Id": 5,
      //         "ArName": "waiting",
      //         "EnName": "waiting",
      //         "Color": "#0bf4ae",
      //       },
      //       {
      //         "Id": 6,
      //         "ArName": "open",
      //         "EnName": "open",
      //         "Color": "#10f4f0",
      //       },
      //       {
      //         "Id": 7,
      //         "ArName": "DemoDemoDemoDemo DemoDemo DemoDemo Demo Demo",
      //         "EnName": "Demo",
      //         "Color": "#56e907",
      //       },
      //       {
      //         "Id": 8,
      //         "ArName": "waiting",
      //         "EnName": "waiting",
      //         "Color": "#0bf4ae",
      //       },
      //       {
      //         "Id": 9,
      //         "ArName": "open",
      //         "EnName": "open",
      //         "Color": "#10f4f0",
      //       },
      //       {
      //         "Id": 10,
      //         "ArName": "Demo",
      //         "EnName": "Demo",
      //         "Color": "#56e907",
      //       },
      //       {
      //         "Id": 11,
      //         "ArName": "waiting",
      //         "EnName": "waiting",
      //         "Color": "#0bf4ae",
      //       },
      //       {
      //         "Id": 12,
      //         "ArName": "open",
      //         "EnName": "open",
      //         "Color": "#10f4f0",
      //       },
      //     ],
      //     "numberofrecords": 12
      //   }
      // };
      ScreenModel screenModel = ScreenModel.fromJson(data);

      return right(screenModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, PermissionModel>> getPagePermissions(
      String pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await apiService.get(
        endPoint: "home/GetPagePermissions?pageId=$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      PermissionModel permissionModel = PermissionModel.fromJson(data);

      return right(permissionModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}