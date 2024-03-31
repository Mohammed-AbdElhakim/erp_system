import 'package:erp_system/core/utils/app_strings.dart';
import 'package:hive/hive.dart';

import '../models/menu_model/menu_model.dart';

abstract class HomeLocalDataSources {
  MenuModel getMenu();
}

class HomeLocalDataSourcesImpl extends HomeLocalDataSources {
  @override
  MenuModel getMenu() {
    var box = Hive.box<MenuModel>(AppStrings.menuModelBox);
    return box.values as MenuModel;
  }
}
