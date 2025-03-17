import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class BuildRadioButtonsWidget extends StatefulWidget {
  const BuildRadioButtonsWidget({super.key, required this.selectedType});
  final void Function(String type) selectedType;

  @override
  State<BuildRadioButtonsWidget> createState() => _BuildRadioButtonsWidgetState();
}

class _BuildRadioButtonsWidgetState extends State<BuildRadioButtonsWidget> {
  String? _selected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customRadio(context, title: S.of(context).outgoing, value: "outgoing"),
        customRadio(context, title: S.of(context).incoming, value: "incoming"),
      ],
    );
  }

  Row customRadio(BuildContext context, {required String value, required String title}) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selected,
          onChanged: (newValue) {
            setState(() {
              _selected = newValue;
              widget.selectedType(_selected!);
            });
          },
        ),
        Text(title, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
