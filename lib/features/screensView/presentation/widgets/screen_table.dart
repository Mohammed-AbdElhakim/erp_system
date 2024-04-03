import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/my_table.dart';
import '../manager/getScreen/get_screen_cubit.dart';
import 'buttons.dart';

class ScreenTable extends StatefulWidget {
  const ScreenTable({super.key});

  @override
  State<ScreenTable> createState() => _ScreenTableState();
}

class _ScreenTableState extends State<ScreenTable> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetScreenCubit, GetScreenState>(
      builder: (context, state) {
        if (state is GetScreenSuccess) {
          List<String> listHeader = [];
          List<dynamic> listData = [];
          for (var item in state.screenModel.columList) {
            listHeader.add(lang == AppStrings.enLangKey
                ? item.enColumnLabel
                : item.arColumnLabel);
            listData.add(item.ColumnName);
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const Buttons(),
                Expanded(
                  child: MyTable(
                    columnNumber: listHeader.length,
                    numberItemInList: 2,
                    // numberItemInList: state.screenModel.dataList.numberofrecords,
                    listHeader: listHeader,
                    list: state.screenModel.dataList.dynamicList,
                    listData: listData,
                    widthOtherColumn: MediaQuery.of(context).size.width * .3,
                    widthFirstColumn: MediaQuery.of(context).size.width * .3,
                    onTap: (w) {
                      print("#####################");
                      print(w);
                      print("##########################");
                    },
                    // heightHeader: 60,
                  ),
                ),
              ],
            ),
          );
        } else if (state is GetScreenFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
