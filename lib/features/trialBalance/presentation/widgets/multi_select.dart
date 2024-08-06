import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/trial_balance_body_model.dart';
import '../manager/trialBalance/trial_balance_cubit.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect(
      {super.key,
      required this.items,
      required this.selectionItems,
      required this.dateFrom,
      required this.dateTo,
      required this.checkboxValue,
      required this.context});
  final List<String> items;
  final List<String> selectionItems;
  final String dateFrom;
  final String dateTo;
  final bool checkboxValue;
  final BuildContext context;

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  late List<String> selectedItems;
  @override
  void initState() {
    selectedItems = widget.selectionItems;
    super.initState();
  }

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void cansel() {
    Navigator.pop(context);
  }

  void okButton() {
    BlocProvider.of<TrialBalanceCubit>(widget.context).getTrialBalance(
      trialBalanceBody: TrialBalanceBodyModel(
          datefrom: widget.dateFrom,
          dateto: widget.dateTo,
          product: 0,
          comID: 0,
          iszero: widget.checkboxValue,
          currancy: 0,
          customer: 0,
          supplier: 0,
          cost: 0,
          iscompany: true),
    );

    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).show),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map(
                (item) => CheckboxListTile(
                  title: Text(item),
                  value: selectedItems.contains(item),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => itemChange(item, isChecked!),
                ),
              )
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: cansel,
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: okButton,
          child: Text(S.of(context).ok),
        ),
      ],
    );
  }
}
