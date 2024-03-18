import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../widgets/host_view_body.dart';

class HostView extends StatelessWidget {
  const HostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).host_view),
      ),
      body: const HostViewBody(),
    );
  }
}
