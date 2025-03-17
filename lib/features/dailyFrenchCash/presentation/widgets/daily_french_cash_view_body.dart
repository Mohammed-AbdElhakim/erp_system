import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/dailyFrenchCash/data/models/body_request_daily_french_cash.dart';
import 'package:erp_system/features/dailyFrenchCash/presentation/manager/dailyFrenchCash/daily_french_cash_cubit.dart';
import 'package:erp_system/features/dailyFrenchCash/presentation/widgets/custom_table_daily_french_cash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/models/accounts_model.dart';
import '../../data/models/daily_french_cash_model.dart';
import 'build_daily_french_cash_input.dart';

class DailyFrenchCashViewBody extends StatefulWidget {
  const DailyFrenchCashViewBody({super.key, required this.accountsList});
  final List<AccountsList> accountsList;

  @override
  State<DailyFrenchCashViewBody> createState() => _DailyFrenchCashViewBodyState();
}

class _DailyFrenchCashViewBodyState extends State<DailyFrenchCashViewBody> {
  late BodyRequestDailyFrenchCash inputMyData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: BuildDailyFrenchCashInput(
              accountsList: widget.accountsList,
              dataInput: (dataInput) {
                setState(() {
                  inputMyData = dataInput;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          BlocBuilder<DailyFrenchCashCubit, DailyFrenchCashState>(
            builder: (context, state) {
              if (state is DailyFrenchCashLoading) {
                return const CustomLoadingWidget();
              } else if (state is DailyFrenchCashFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else if (state is DailyFrenchCashSuccess) {
                DailyFrenchCashModel dailyFrenchCashModel = state.dailyFrenchCashModel;
                String title = inputMyData.creditOrDepit
                    ? "واردة من حساب من فترة ${DateFormat('MMM d, y', 'en').format(DateTime.parse(inputMyData.dateFrom))} إلى فترة ${DateFormat('MMM d, y', 'en').format(DateTime.parse(inputMyData.dateTo))}"
                    : "صادرة من حساب من فترة ${DateFormat('MMM d, y', 'en').format(DateTime.parse(inputMyData.dateFrom))} إلى فترة ${DateFormat('MMM d, y', 'en').format(DateTime.parse(inputMyData.dateTo))}";
                return Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(title),
                      ),
                      CustomTableDailyFrenchCash(
                        dailyFrenchCashModel: dailyFrenchCashModel,
                      )
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
