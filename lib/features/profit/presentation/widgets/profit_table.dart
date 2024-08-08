import 'package:flutter/material.dart';

import '../../data/models/profit_model.dart';

class ProfitTable extends StatefulWidget {
  const ProfitTable({super.key, required this.profitList});
  final List<ProfitModel> profitList;
  // final List<String> selectionItemsShow;

  @override
  State<ProfitTable> createState() => _ProfitTableState();
}

class _ProfitTableState extends State<ProfitTable> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
