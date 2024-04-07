import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../manager/getTable/get_table_cubit.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  String? lang;

  List<IconData> iconList = [
    Icons.search,
    Icons.refresh,
    Icons.delete,
    Icons.edit_note,
    Icons.add,
  ];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTableCubit, GetTableState>(
      listener: (context, state) {
        if (state is GetScreenSuccess) {
          List<dynamic> listData = state.screenModel.dataList.dynamicList;
          List<String> listHeader = [];
          List<dynamic> listKey = [];
          for (var item in state.screenModel.columList) {
            listHeader.add(lang == AppStrings.enLangKey
                ? item.enColumnLabel
                : item.arColumnLabel);
            listKey.add(item.ColumnName);
          }
        }
      },
      builder: (context, state) {
        return SpeedDial(
          backgroundColor: AppColors.blueLight,
          overlayOpacity: 0.5,
          activeIcon: Icons.close,
          iconTheme: IconThemeData(color: AppColors.white),
          buttonSize: const Size(58, 58),
          curve: Curves.easeIn,
          children: List.generate(
            iconList.length,
            (index) => SpeedDialChild(
                elevation: 0,
                backgroundColor: getColor(iconList[index]),
                shape: const CircleBorder(),
                child: Icon(
                  iconList[index],
                  color: AppColors.white,
                ),
                onTap: () {
                  tapIcon(iconList[index]);
                }),
          ),
          child: Icon(
            Icons.settings,
            color: AppColors.white,
          ),
        );
      },
    );
  }

  getColor(IconData icon) {
    if (icon == Icons.search) {
      return AppColors.blue;
    } else if (icon == Icons.refresh) {
      return AppColors.orange;
    } else if (icon == Icons.delete) {
      return AppColors.red;
    } else if (icon == Icons.edit_note) {
      return AppColors.blueGreyDark;
    } else if (icon == Icons.add) {
      return AppColors.blueLight;
    }
  }

  void tapIcon(IconData icon) {
    if (icon == Icons.search) {
      print("search");
    } else if (icon == Icons.refresh) {
      print("refresh");
    } else if (icon == Icons.delete) {
      print("delete");
    } else if (icon == Icons.edit_note) {
      print("edit note");
    } else if (icon == Icons.add) {
      print("add");
    }
  }
}
