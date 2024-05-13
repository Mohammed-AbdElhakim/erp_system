import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';
import 'host_view_form.dart';

class HostViewBody extends StatelessWidget {
  const HostViewBody({super.key, required this.isPortrait});
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (isPortrait)
          CustomContainer(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Text(
                textAlign: TextAlign.center,
                S.of(context).host_view,
                style: AppStyles.textStyle26,
              ),
            ),
          ),
        const HostViewForm(),
      ],
    );
  }
}
