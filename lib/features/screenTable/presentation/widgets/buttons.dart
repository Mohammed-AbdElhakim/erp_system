// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// final double buttonSize = 40;
//
// class Buttons extends StatefulWidget {
//   const Buttons({super.key});
//
//   @override
//   State<Buttons> createState() => _ButtonsState();
// }
//
// class _ButtonsState extends State<Buttons> with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 250));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Flow(
//       delegate: FlowMenuDelegate(controller: controller),
//       children: <IconData>[
//         Icons.search,
//         Icons.refresh,
//         Icons.add,
//         Icons.edit_note,
//         Icons.delete,
//         Icons.menu
//       ].map<Widget>(buildFAB).toList(),
//     );
//   }
//
//   Widget buildFAB(IconData icon) {
//     return SizedBox(
//       height: buttonSize,
//       width: buttonSize,
//       child: FloatingActionButton(
//           elevation: 0,
//           splashColor: Colors.black,
//           child: Icon(
//             icon,
//             size: 35,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             if (controller.status == AnimationStatus.completed) {
//               controller.reverse();
//             } else {
//               controller.forward();
//             }
//           }),
//     );
//   }
// }
//
// class FlowMenuDelegate extends FlowDelegate {
//   final Animation<double> controller;
//
//   FlowMenuDelegate({super.repaint, required this.controller});
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final xStart = size.width - buttonSize;
//     final yStart = size.height - buttonSize;
//
//     final n = context.childCount;
//     for (int i = 0; i < n; i++) {
//       final isLastItem = i == context.childCount - 1;
//       final setValue = (value) => isLastItem ? 0.0 : value;
//       final radius = 180 * controller.value;
//       final theta = i * pi * 0.5 / (n - 2);
//       final x = xStart - setValue(radius * cos(theta));
//       final y = yStart - setValue(radius * sin(theta));
//       context.paintChild(
//         i,
//         transform: Matrix4.identity()
//           ..translate(x, y, 0)
//           ..translate(buttonSize / 2, buttonSize / 2)
//           ..rotateZ(isLastItem ? 0.0 : 180 * (1 - controller.value) * pi / 180)
//           ..scale(isLastItem ? 1.0 : max(controller.value, 0.5))
//           ..translate(-buttonSize / 2, -buttonSize / 2),
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant FlowDelegate oldDelegate) {
//     // TODO: implement shouldRepaint
//     throw UnimplementedError();
//   }
// }
