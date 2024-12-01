import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_loading_widget.dart';

class BuildNumberCard extends StatelessWidget {
  const BuildNumberCard({super.key, required this.title, required this.value, required this.icon});

  final String title;
      final double value;
      final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade900)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              // width: 90,
              // height: 90,
              // fit: BoxFit.fill,
              imageUrl: "http://$icon",
              placeholder: (context, url) => const CustomLoadingWidget(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 35,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "$value",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                title,
                style: TextStyle(color: Colors.blue.shade900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
