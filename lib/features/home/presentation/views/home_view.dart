import 'package:flutter/material.dart';

import '../../data/models/fast_screen_model.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/item_grid_view.dart';
import '../widgets/my_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FastScreenModel> listScreens = [
    FastScreenModel(
        image: "sales_ report",
        title: " تقريرالمبيعات",
        colorBackground: 0xFF6FC063),
    FastScreenModel(
        image: "smartphone",
        title: "تقرير المشتريات",
        colorBackground: 0xFF6FC063),
    FastScreenModel(
        image: "store", title: "رصيد الخزنة", colorBackground: 0xFF6FC063),
    FastScreenModel(
        image: "stock", title: " تقريرالمبيعات", colorBackground: 0xFF6FC063),
    FastScreenModel(
        image: "sales_ report",
        title: " تقريرالمبيعات",
        colorBackground: 0xFF6FC063),
    FastScreenModel(
        image: "sales_ report",
        title: " تقريرالمبيعات",
        colorBackground: 0xFF6FC063),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Home"),
      ),
      drawer: const MyDrawer(),
      body: GridView.count(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 3 : 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        childAspectRatio: 0.75,
        children: <Widget>[
          ItemGridView(
            icon: "sales_ report",
            title: " تقريرالمبيعات",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => CustomerSaleDetails()),
              // );
            },
          ),
          ItemGridView(
            icon: "smartphone",
            title: "تقرير المشتريات",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => BuyReports()),
              // );
            },
          ),
          ItemGridView(
            icon: "store",
            title: "رصيد الخزنة",
            onTap: () {
              // StockNowCounterScreen().stockNowCounter(context);
            },
          ),
          ItemGridView(
            icon: "stock",
            title: "جرد مخزن",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StoresScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "delegates",
            title: "حساب موردين",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const SuppliersMoneyScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "client",
            title: "حساب عملاء",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const CustomersMoneyScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "money_1",
            title: "ايراد خارجى",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const EradAndKhosaraScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "money_2",
            title: "خسارة خارجية",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const EradAndKhosaraScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "money",
            title: "تقرير المصروفات",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const DeservedScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "money_3",
            title: "تقرير المرتبات",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const EmployeeSalaryScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "report",
            title: "اجمالى الحسابات",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ReportsTotalScreen()),
              // );
            },
          ),
          ItemGridView(
            icon: "return",
            title: "تقرير التوالف",
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ProductsOutStoreScreen()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
