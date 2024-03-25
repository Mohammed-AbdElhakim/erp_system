import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/fast_screen_model.dart';
import '../widgets/item_home.dart';
import '../widgets/my_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FastScreenModel> listScreens = [
    FastScreenModel(
        id: "/attendanceView",
        image: "sales_ report",
        title: "حضور وانصراف",
        colorBackground: 0xFF6FC063),
    FastScreenModel(
        id: "/attendanceView",
        image: "smartphone",
        title: "تقرير المشتريات",
        colorBackground: 0xFF7A5649),
    FastScreenModel(
        id: "/attendanceView",
        image: "store",
        title: "رصيد الخزنة",
        colorBackground: 0xFFD94949),
    FastScreenModel(
        id: "/attendanceView",
        image: "stock",
        title: "جرد مخزن",
        colorBackground: 0xFFF8951D),
    FastScreenModel(
        id: "/attendanceView",
        image: "sales_ report",
        title: "حساب موردين",
        colorBackground: 0xFF9062AA),
    FastScreenModel(
        id: "/attendanceView",
        image: "sales_ report",
        title: "حساب ",
        colorBackground: 0xFF9062AA),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const MyDrawer(),
        body: ListView.builder(
          itemCount: (listScreens.length / 2).ceil(),
          itemBuilder: (context, index) {
            int i = index + 1;
            return ItemHome(
              item1: listScreens[index + index],
              item2: listScreens[index + i],
              i: i,
            );
          },
        ),
      ),
    );
  }
}
/*
* Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color(0xFF6FC063),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/sales_ report.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFF5C9F52),
                          child: AutoSizeText(" تقريرالمبيعات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xFF3EB3E8),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/store.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFF369AC7),
                          child: AutoSizeText("رصيد الخزنة",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xFFD94949),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/cashier.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFFB73D3D),
                          child: AutoSizeText(" تقريرالمبيعات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color(0xFF9062AA),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/sales_ report.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFF734F88),
                          child: AutoSizeText(" تقريرالمبيعات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color(0xFFF8951D),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/sales_ report.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFFE0871B),
                          child: AutoSizeText(" تقريرالمبيعات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xFF7A5649),
                    margin: EdgeInsets.all(1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/sales_ report.png",
                            width: 85,
                            height: 70,
                          ),
                        ),
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          color: Color(0xFF64463C),
                          child: AutoSizeText(" تقريرالمبيعات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )*/

/*GridView.count(
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
      )*/
