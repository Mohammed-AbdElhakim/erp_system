import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/methods.dart';
import '../core/widgets/custom_app_bar.dart';
import 'bottomNavigationBar/presentation/widgets/my_drawer.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: "Information",
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_sharp),
              ),
              Positioned(
                right: 12,
                top: 15,
                child: Icon(
                  Icons.circle,
                  color: AppColors.orange,
                  size: 12,
                ),
              )
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text('Information'),
      ),
    );
  }
}
