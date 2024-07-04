import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/tap_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPageDetails/get_page_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/menu_model/pages.dart';
import 'tap_details_widget.dart';

class DetailsRowViewBody extends StatelessWidget {
  const DetailsRowViewBody(
      {super.key, required this.pageData, required this.rowData});
  final Pages pageData;
  final Map<String, dynamic> rowData;

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
                    child: TapDetailsWidget(
                      tap: tapsList[index],
                      pageData: pageData,
                      id: rowData[pageData.primary].toString(),
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
