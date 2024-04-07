import 'package:erp_system/features/screenTable/presentation/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
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
          List<dynamic> listData = state.screenModel.dataList.dynamicList;
          List<String> listHeader = [];
          List<dynamic> listKey = [];
          for (var item in state.screenModel.columList) {
            listHeader.add(lang == AppStrings.enLangKey
                ? item.enColumnLabel
                : item.arColumnLabel);
            listKey.add(item.ColumnName);
          }
          return Expanded(
            child: CustomTable(
              listHeader: listHeader,
              listData: listData,
              listKey: listKey,
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

/*Expanded(
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
          )*/

/*Table(
                  border: TableBorder.all(color: Colors.white),
                  defaultVerticalAlignment:
                      TableCellVerticalAlignment.intrinsicHeight,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.blue),
                      children: [
                        ...List.generate(
                          listHeader.length,
                          (index) => TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                                // height: 35,
                                alignment: Alignment.center,
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 8),
                                child: Text(
                                  listHeader[index],
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyle14,
                                )),
                          ),
                        )
                      ],
                    ),
                    ...List.generate(
                      30,
                      (index) => TableRow(
                        decoration: BoxDecoration(
                            color:
                                index.isEven ? Colors.blue[50] : Colors.white),
                        children: List<TableCell>.generate(
                          listHeader.length,
                          (i) => TableCell(
                            child: Text(listData[i]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),*/
