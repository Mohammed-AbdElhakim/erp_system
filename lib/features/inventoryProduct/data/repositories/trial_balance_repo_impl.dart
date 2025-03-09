import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/inventory_product_body_model.dart';
import '../models/inventory_product_model.dart';
import 'inventory_product_repo.dart';

class InventoryProductRepoImpl implements InventoryProductRepo {
  final ApiService apiService;

  InventoryProductRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<InventoryProductModel>>> getInventoryProduct({
    required InventoryProductBodyModel inventoryProductBody,
  }) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      // var rrr = jsonEncode(inventoryProductBody.toJson());
      Map<String, dynamic> data = await apiService.post(
        endPoint: "web/TrialAccount",
        data: inventoryProductBody.toJson(),
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<InventoryProductModel> dataList = [];
      for (var i in data['display']) {
        dataList.add(InventoryProductModel.fromJson(i));
      }

      return right(dataList);
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
