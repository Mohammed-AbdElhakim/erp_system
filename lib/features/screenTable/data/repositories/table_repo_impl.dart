import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/features/screenTable/data/repositories/table_repo.dart';

import '../../../../core/utils/api_service.dart';
import '../models/column_data_model.dart';

class TableRepoImpl implements TableRepo {
  final ApiService apiService;

  TableRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ScreenModel>> getTable(Pages page) async {
    try {
      // String companyKey =
      //     await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
      //         "";
      // String token =
      //     await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // Map<String, dynamic> data = await apiService.get(
      //   endPoint: "home/getmenu",
      //   headers: {
      //     "Authorization": "Bearer $token",
      //     "CompanyKey": companyKey,
      //   },
      // );
      Map<String, dynamic> data = {
        "columList": [
          {
            "id": 131749,
            "ListName": "offerstates",
            "ColumnName": "EnName",
            "enColumnLabel": " English Name ",
            "arColumnLabel": "الاسم بالانجليزية",
            "InsertVisable": true,
            "InsertType": "text",
            "userID": 4121,
            "ListID": 16843,
            "sort": 1,
            "visible": true,
            "Cvisable": true,
            "validation": "required",
            "isKey": false,
            "IsRquired": false,
            "SearchName": "EnName",
            "IsTotal": false,
            "InsertDefult": true,
            "VisableDefult": true,
            "Width": 140,
            "MobileVisable": true,
            "ComID": 1,
            "MasterInsertVisible": true
          },
          {
            "id": 131748,
            "ListName": "offerstates",
            "ColumnName": "ArName",
            "enColumnLabel": " Arabic Name ",
            "arColumnLabel": "الاسم بالعربية",
            "InsertVisable": true,
            "InsertType": "text",
            "userID": 4121,
            "ListID": 16842,
            "sort": 2,
            "visible": true,
            "Cvisable": true,
            "validation": "required",
            "isKey": false,
            "IsRquired": false,
            "SearchName": "ArName",
            "IsTotal": false,
            "InsertDefult": true,
            "VisableDefult": true,
            "Width": 140,
            "MobileVisable": true,
            "ComID": 1,
            "MasterInsertVisible": true
          },
          {
            "id": 131750,
            "ListName": "offerstates",
            "ColumnName": "Id",
            "enColumnLabel": " English Name ",
            "arColumnLabel": "ID",
            "InsertVisable": false,
            "InsertType": "number",
            "userID": 4121,
            "ListID": 16844,
            "sort": 3,
            "visible": false,
            "Cvisable": false,
            "validation": "required",
            "isKey": false,
            "IsRquired": false,
            "SearchName": "Id",
            "IsTotal": false,
            "InsertDefult": true,
            "VisableDefult": true,
            "Width": 140,
            "MobileVisable": true,
            "ComID": 1,
            "MasterInsertVisible": false
          },
          {
            "id": 131757,
            "ListName": "offerstates",
            "ColumnName": "Color",
            "enColumnLabel": "Color",
            "arColumnLabel": "اللون",
            "InsertVisable": true,
            "InsertType": "color",
            "userID": 4121,
            "ListID": 16863,
            "sort": 4,
            "visible": true,
            "Cvisable": true,
            "validation": "required",
            "isKey": false,
            "IsRquired": false,
            "SearchName": "Color",
            "IsTotal": false,
            "InsertDefult": true,
            "VisableDefult": true,
            "Width": 140,
            "MobileVisable": true,
            "ComID": 1,
            "MasterInsertVisible": true
          },
        ],
        "dataList": {
          "dynamicList": [
            {
              "Id": 3,
              "ArName": "Demo",
              "EnName": "Demo",
              "Color": "#56e907",
            },
            {
              "Id": 2,
              "ArName": "waiting",
              "EnName": "waiting",
              "Color": "#0bf4ae",
            },
            {
              "Id": 1,
              "ArName": "open",
              "EnName": "open",
              "Color": "#10f4f0",
            },
            {
              "Id": 3,
              "ArName": "Demo",
              "EnName": "Demo",
              "Color": "#56e907",
            },
            {
              "Id": 2,
              "ArName": "waiting",
              "EnName": "waiting",
              "Color": "#0bf4ae",
            },
            {
              "Id": 1,
              "ArName": "open",
              "EnName": "open",
              "Color": "#10f4f0",
            },
          ],
          "numberofrecords": 6
        }
      };
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
}
