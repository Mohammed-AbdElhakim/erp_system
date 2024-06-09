import '../../../../core/models/menu_model/pages.dart';
import 'screen_model.dart';

class AddPassDataModel {
  final List<ColumnList> columnList;
  final Pages pageData;
  final List<dynamic> listKey;

  AddPassDataModel(
      {required this.columnList,
      required this.pageData,
      required this.listKey});
}
