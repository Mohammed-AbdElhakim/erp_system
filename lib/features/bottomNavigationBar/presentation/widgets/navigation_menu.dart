import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/navigation_model.dart';

typedef ValueChanged<T> = void Function(T value);

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.onChanged});
  final ValueChanged<int> onChanged;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  List<NavigationModel> listNavigation = [
    NavigationModel(id: 1, icon: Icons.home_outlined),
    NavigationModel(id: 2, icon: Icons.location_on_outlined),
    NavigationModel(id: 3, icon: Icons.email_outlined),
    NavigationModel(id: 4, icon: Icons.person_outline),
  ];
  int selectIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: gradientContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: listNavigation.map((e) {
          return Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: selectIndex == e.id
                      ? AppColors.white.withOpacity(0.10)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      selectIndex = e.id;
                      widget.onChanged(selectIndex);
                    });
                  },
                  icon: Icon(
                    e.icon,
                    size: selectIndex == e.id ? 30 : 20,
                    color: selectIndex == e.id
                        ? AppColors.white
                        : AppColors.white.withOpacity(0.8),
                  ),
                ),
              ),
              if (e.id == 4)
                Positioned(
                  right: selectIndex == e.id ? 10 : 13,
                  top: selectIndex == e.id ? 12 : 15,
                  child: Icon(
                    Icons.circle,
                    color: selectIndex == e.id
                        ? Colors.orange
                        : Colors.orange.withOpacity(0.8),
                    size: selectIndex == e.id ? 12 : 10,
                  ),
                )
            ],
          );
        }).toList(),
      ),
    );
  }
}