import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/core/widgets/custom_container.dart';
import 'package:erp_system/features/host/presentation/widgets/host_view_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class HostViewBody extends StatelessWidget {
  const HostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
