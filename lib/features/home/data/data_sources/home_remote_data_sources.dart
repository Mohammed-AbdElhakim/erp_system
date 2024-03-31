import '../models/menu_model.dart';

abstract class HomeRemoteDataSources {
  Future<MenuModel> getMenu();
}

class HomeRemoteDataSourcesImpl extends HomeRemoteDataSources {
  @override
  Future<MenuModel> getMenu() {
    // TODO: implement getMenu
    throw UnimplementedError();
  }
}
