import 'package:flutter/material.dart';

import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/host_view_body.dart';

class HostView extends StatefulWidget {
  const HostView({super.key});

  @override
  State<HostView> createState() => _HostViewState();
}

class _HostViewState extends State<HostView> {
  @override
  Widget build(BuildContext context) {
    return const ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: HostViewBody(),
      ),
    );
  }
}
