import 'package:flutter/material.dart';

import '../../features/Reports/presentation/views/reports_view.dart';
import '../../features/accountProf/presentation/views/account_prof_view.dart';
import '../../features/attendance/presentation/views/attendance_view.dart';
import '../../features/cashier/presentation/views/cashier_view.dart';
import '../../features/chart/presentation/views/chart_view.dart';
import '../../features/customerAccount/presentation/views/customer_account_view.dart';
import '../../features/dailyFrenchCash/presentation/views/daily_french_cash_view.dart';
import '../../features/generalBalance/presentation/views/general_balance_view.dart';
import '../../features/inventoryProduct/presentation/views/inventory_product.dart';
import '../../features/productCard/presentation/views/product_card_view.dart';
import '../../features/profit/presentation/views/profit_view.dart';
import '../../features/projectProcess/presentation/views/project_process_view.dart';
import '../../features/screenTable/presentation/views/screen_table.dart';
import '../../features/storeShow/presentation/views/store_show_view.dart';
import '../../features/supplierCustomerProcess/presentation/views/supplier_customer_process_view.dart';
import '../../features/supplierProcess/presentation/views/supplier_process_view.dart';
import '../../features/tasks/presentation/views/tasks_view.dart';
import '../../features/taxDeclaration/presentation/views/tax_declaration_view.dart';
import '../../features/trialBalance/presentation/views/trial_balance.dart';
import '../models/menu_model/pages.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({super.key, required this.pageData});

  final Pages pageData;

  @override
  Widget build(BuildContext context) {
    return getWidgetBody(pageData);
  }

  getWidgetBody(Pages pageData) {
    switch (pageData.url) {
      case "mobileAttendance":
        return AttendanceView(pageData: pageData);
      case "employeeTask":
        return TasksView(pageData: pageData);
      case "chart":
        return ChartView(pageData: pageData);
      case "DailyFrenshCash":
        return DailyFrenchCashView(pageData: pageData);
      case "general":
        switch (pageData.tableSrc) {
          case "profit":
            return ProfitView(pageData: pageData);
          case "genralBalance":
            return GeneralBalanceView(pageData: pageData);
          case "trialBalance":
            return TrialBalance(pageData: pageData);
          case "cashier":
            return CashierView(pageData: pageData);
          case "PivotTable":
            return ReportsView(pageData: pageData);
          case "customerAccountReport":
            return CustomerAccountView(pageData: pageData);
          case "profAccount":
            return AccountProfView(pageData: pageData);
          case "supplierProccess":
            return SupplierProcessView(pageData: pageData);
          case "prodCard":
            return ProductCardView(pageData: pageData);
          case "storeshow":
            return StoreShowView(pageData: pageData);
          case "ProjectProcess":
            return ProjectProcessView(pageData: pageData);
          case "inventoryProduct":
            return InventoryProduct(pageData: pageData);
          case "TaxDeclaration":
            return TaxDeclarationView(pageData: pageData);
          case "supplierCustomerProccess":
            return SupplierCustomerProcessView(
              pageData: pageData,
            );
          default:
            return ScreenTable(pageData: pageData);
        }
      default:
        return Scaffold(
          body: Center(child: Text("Url => ${pageData.url}")),
        );
    }
  }
}
