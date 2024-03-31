import 'package:flutter/material.dart';

class CustomErrorMassage extends StatelessWidget {
  const CustomErrorMassage({super.key, required this.errorMassage});
  final String errorMassage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMassage,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
