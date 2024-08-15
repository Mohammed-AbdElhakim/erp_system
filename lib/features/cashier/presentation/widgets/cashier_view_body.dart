import 'package:flutter/material.dart';

import 'custom_app_bar_body.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody({super.key, required this.title});
  final String title;

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBody(title: widget.title),
      drawer: Drawer(
        child: Container(),
      ),
    );
  }
}
