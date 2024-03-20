import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import 'custom_drawer_header.dart';
import 'custom_main_list_tile_in_drawer.dart';
import 'custom_sub_list_tile_in_drawer.dart';
import 'log_out_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      backgroundColor: Theme.of(context).primaryColor,
      child: Container(
        // color: Color(0x8d841eff),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomDrawerHeader(userName: 'Mohamed'),

              //العملاء
              CustomMainListTileInDrawer(
                title: "العملاء",
                icon: "client",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_1,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const CustomerSaleDetails()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_1_1,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const CustomerSaleRep7Details()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item4,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const CustomerKashfHesapScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item6,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const CustomersReportScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item8,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const CustomersMoneyScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //الكاشير
              CustomMainListTileInDrawer(
                title: "الكاشير",
                icon: "cashier",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_2,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const UsernameSaleDetails()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_2_2,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const UsernameSaleRep7Details()),
                      // );
                    },
                  ),
                ],
              ),
              //المندوبيين
              CustomMainListTileInDrawer(
                icon: "delegates",
                title: "المندوبيين",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_3,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const DelegatenameSaleDetails()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item1_3_3,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const DelegatenameSaleRep7Details()),
                      // );
                    },
                  ),
                ],
              ),

              //الموردين
              CustomMainListTileInDrawer(
                icon: "suppliers",
                title: "الموردين",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.item3,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const SupplierKashfHesapScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item5,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const SuppliersReportScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item7,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const SuppliersMoneyScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //المنتجات
              CustomMainListTileInDrawer(
                icon: "products",
                title: "المنتجات",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.item2,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const BuyReports()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.item9,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ProductsScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.expire,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const ProductsQtyGetAllExpireScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.rangeOrder,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const RangeOrderScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.returnsDetails,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ReturnsDetailsScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.productsOutStore,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const ProductsOutStoreScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //المصروفات
              CustomMainListTileInDrawer(
                icon: "money",
                title: "المصروفات",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.deserved,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const DeservedScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.sarfAndKapd,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const SarfAndKapdScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.eradAndKhosara,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const EradAndKhosaraScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //المخازن
              CustomMainListTileInDrawer(
                icon: "stock",
                title: "المخازن",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.stores,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const StoresScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //الخزنات
              CustomMainListTileInDrawer(
                icon: "store",
                title: "الخزنات",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.nowCounter,
                    onTap: () {
                      // Navigator.pop(context);
                      // StockNowCounterScreen().stockNowCounter(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const NowStock()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.stockInsert,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const StockInsertScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.stockPull,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const StockPullScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.stockTransFire,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const StockTransFireScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //البنوك
              CustomMainListTileInDrawer(
                icon: "bank",
                title: "البنوك",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.bankNowCounter,
                    onTap: () {
                      // Navigator.pop(context);
                      // BankNowCounterScreen().bankNowCounter(context);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const NowStock()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.bankInsert,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const BankInsertScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.bankPull,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const BankPullScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.bankTransFire,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const BankTransFireScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //شؤون الموظفين
              CustomMainListTileInDrawer(
                icon: "people",
                title: "شؤون الموظفين",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: AppStrings.attendAndGo,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const EmployeeAttendAndGoScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.employeeIncentives,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const EmployeeIncentivesScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.employeeSanctions,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const EmployeeSanctionsScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.employeeBorrowItem,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const EmployeeBorrowItemScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.employeeBorrowMoney,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           const EmployeeBorrowMoneyScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.employeeSalary,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const EmployeeSalaryScreen()),
                      // );
                    },
                  ),
                  CustomSubListTileInDrawer(
                    title: AppStrings.runCommand,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const RunCommandScreen()),
                      // );
                    },
                  ),
                ],
              ),
              //تقارير
              CustomMainListTileInDrawer(
                icon: "report",
                title: "تقارير",
                bodyList: [
                  CustomSubListTileInDrawer(
                    title: "تقارير اجمالى الحسابات",
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ReportsTotalScreen()),
                      // );
                    },
                  ),
                ],
              ),
              const LogoutItem(),
            ],
          ),
        ),
      ),
    );
  }
}
