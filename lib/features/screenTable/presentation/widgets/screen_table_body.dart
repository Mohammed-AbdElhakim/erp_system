import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/my_table.dart';
import '../manager/getTable/get_table_cubit.dart';

class ScreenTableBody extends StatefulWidget {
  const ScreenTableBody({super.key});

  @override
  State<ScreenTableBody> createState() => _ScreenTableBodyState();
}

class _ScreenTableBodyState extends State<ScreenTableBody> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTableCubit, GetTableState>(
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
          return Expanded(
            child: MyTable(
              columnNumber: listHeader.length,
              numberItemInList: 2,
              // numberItemInList: state.screenModel.dataList.numberofrecords,
              listHeader: listHeader,
              list: state.screenModel.dataList.dynamicList,
              listData: listData,
              widthOtherColumn: MediaQuery.of(context).size.width * .3,
              widthFirstColumn: MediaQuery.of(context).size.width * .3,
              onTap: (value) {},
              // heightHeader: 60,
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
