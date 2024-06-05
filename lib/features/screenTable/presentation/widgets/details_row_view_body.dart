import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/tap_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPageDetails/get_page_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class DetailsRowViewBody extends StatelessWidget {
  const DetailsRowViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
      builder: (context, state) {
        if (state is GetPageDetailsSuccess) {
          List<ListTaps> tapsList = state.tapModel.list;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                  tapsList.length,
                  (index) => Card(
                    elevation: 2,
                    child: ExpansionTile(
                      collapsedShape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Text(
                        tapsList[index].displayArabic,
                        style:
                            AppStyles.textStyle18.copyWith(color: Colors.black),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 0,
                              horizontalMargin: 15,
                              dataRowMinHeight: 35,
                              dataRowMaxHeight: 35,
                              headingRowHeight: 35,
                              headingRowColor: MaterialStateProperty.all(
                                  AppColors.blueLight),
                              columns: [
                                ...List.generate(
                                  12,
                                  (index) {
                                    return DataColumn(
                                      label: Expanded(
                                        child: SizedBox(
                                          width: 130,
                                          child: Text(
                                            "column $index",
                                            textAlign: TextAlign.center,
                                            style: AppStyles.textStyle14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                              rows: List.generate(
                                5,
                                (index) => DataRow(
                                  cells: [
                                    ...List.generate(
                                      12,
                                      (i) => DataCell(
                                        SizedBox(
                                          width: 130,
                                          child: InkWell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: const Text("text"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is GetPageDetailsFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
