import 'package:hive/hive.dart';

import '../../../features/home/data/models/menu_model/menu_model.dart';

class LocalData {
  static void saveMenuModelInLocal({
    required MenuModel menuModel,
    required String boxName,
  }) {
    var box = Hive.box<MenuModel>(boxName);
    box.addAll(menuModel as Iterable<MenuModel>);
  }
}
