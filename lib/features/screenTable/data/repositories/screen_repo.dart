import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../models/dropdown_model/all_dropdown_model.dart';
import '../models/dropdown_model/dropdown_model.dart';
import '../models/expenses_details_model.dart';
import '../models/item_list_setup_model.dart';
import '../models/permission_model.dart';
import '../models/screen_model.dart';
import '../models/tap_model.dart';

abstract class ScreenRepo {
  Future<Either<Failure, ScreenModel>> getTable({
    required int pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
    required bool isDepartment,
    required String departmentName,
    required int authorizationID,
    required String viewEmployeeColumn,
  });
  Future<Either<Failure, PermissionModel>> getPagePermissions(String pageId);
  Future<Either<Failure, Map<String, dynamic>>> getById(
      String controllerName, String id);

  Future<Either<Failure, String>> add({
    required String controllerName,
    required Map<String, dynamic> body,
  });
  Future<Either<Failure, String>> edit({
    required String controllerName,
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, DropdownModel>> getDropdownList({
    required String droModel,
    required String droValue,
    required String droText,
    required String droCondition,
    required String droCompany,
  });

  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });

  Future<Either<Failure, String>> deleteItem({
    required String controllerName,
    required List<String> listId,
  });

  Future<Either<Failure, TapModel>> getPageDetails({
    required int pageID,
  });

  Future<Either<Failure, ScreenModel>> getPageDetailsTable({
    required ListTaps tapData,
  });

  Future<Either<Failure, List<ItemListSetupModel>>> getListSetups({
    required String pageListName,
  });

  //------------------------------- المصاريف --------------------------

  Future<Either<Failure, String>> addExpenses(
      {required Map<String, dynamic> body, required String controllerName});

  Future<Either<Failure, String>> editExpenses(
      {required Map<String, dynamic> body, required String controllerName});

  Future<Either<Failure, Map<String, dynamic>>> getExpensesMaster(
      {required String id, required String controllerName});

  Future<Either<Failure, ExpensesDetailsModel>> getExpensesDetails({
    required ListTaps tapModel,
  });
  Future<Either<Failure, ExpensesDetailsModel>> getSalesInvoiceDetails({
    required String invoiceID,
  });
}
