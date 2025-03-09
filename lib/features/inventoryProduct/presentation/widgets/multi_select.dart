import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class MultiSelect extends StatefulWidget {
  const MultiSelect({
    super.key,
    required this.items,
    required this.selectionItems,
  });
  final List<String> items;
  final List<String> selectionItems;

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
