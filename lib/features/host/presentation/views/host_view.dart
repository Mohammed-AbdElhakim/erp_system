import 'package:flutter/material.dart';

import '../widgets/host_view_body.dart';

class HostView extends StatelessWidget {
  const HostView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HostViewBody(),
    );
  }
}
