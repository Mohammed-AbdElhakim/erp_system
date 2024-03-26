import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/home/data/models/menu_model.dart';

import '../../../../../core/utils/api_service.dart';
import 'menu_repo.dart';

class MenuRepoImpl implements MenuRepo {
  final ApiService apiService;

  MenuRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<MenuModel>>> getMenu() async {
    try {
      var data = await apiService.get(endPoint: "home/getmenu");
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
