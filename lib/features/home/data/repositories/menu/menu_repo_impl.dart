import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/home/data/models/menu_model.dart';

import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_strings.dart';
import 'menu_repo.dart';

class MenuRepoImpl implements MenuRepo {
  final ApiService apiService;

  MenuRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<MenuModel>>> getMenu() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      var data = await apiService.get(endPoint: "home/getmenu", headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJFbXBJRCI6IjQxMjEiLCJDb21JRCI6IjEiLCJOYW1lIjoiRWd5IER5bmFtaWMiLCJ1c2VyIjoiYWRtaW4iLCJuYmYiOjE3MTE0NzI4ODksImV4cCI6MTcxODM4NDg4OSwiaWF0IjoxNzExNDcyODg5LCJpc3MiOiJFUlBTeXN0ZW1BUEkiLCJhdWQiOiJFUlBTeXN0ZW1DbGllbnRzIn0.FmUeWtOMsTSpgvvVdLTmThvUD_lXvBkogN_wu7afNDbNRqdi-5zWIa9AQ-sXgYVmFe5EVO5zY9hGMwkxjBXY2w",
        // "Cache-Control": "no-cache",
        // "Postman-Token": "<calculated when request is sent>",
        // "Host": "http://161.97.161.180:660/api",
        // "User-Agent": "PostmanRuntime/7.36.3",
        // "Accept": "*/*",
        // "Accept-Encoding": "gzip, deflate, br",
        // "Connection": "keep-alive",
        "CompanyKey": companyKey,
      });
      List<MenuModel> menu = [];
      for (var item in data.values) {
        menu.add(MenuModel.fromJson(item));
      }
      return right(menu);
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
