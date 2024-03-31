import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../models/menu_model/menu_model.dart';

abstract class HomeRemoteDataSources {
  Future<MenuModel> getMenu();
}

class HomeRemoteDataSourcesImpl extends HomeRemoteDataSources {
  final ApiService apiService;

  HomeRemoteDataSourcesImpl(this.apiService);

  @override
  Future<MenuModel> getMenu() async {
    String companyKey =
        await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
            "";
    String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
    Map<String, dynamic> data = await apiService.get(
      endPoint: "home/getmenu",
      headers: {
        "Authorization": "Bearer $token",
        "CompanyKey": companyKey,
      },
    );
    MenuModel menuModel = MenuModel.fromJson(data);

    return menuModel;
  }
}
