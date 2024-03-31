import '../models/menu_model/menu_model.dart';

abstract class HomeLocalDataSources {
  MenuModel getMenu();
}

class HomeLocalDataSourcesImpl extends HomeLocalDataSources {
  @override
  MenuModel getMenu() {
    // TODO: implement getMenu
    throw UnimplementedError();
  }
}
