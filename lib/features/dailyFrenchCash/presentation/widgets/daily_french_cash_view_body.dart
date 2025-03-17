import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/dailyFrenchCash/data/models/body_request_daily_french_cash.dart';
import 'package:erp_system/features/dailyFrenchCash/presentation/manager/dailyFrenchCash/daily_french_cash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/accounts_model.dart';
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
    return Column(
      children: [
        BuildDailyFrenchCashInput(
          accountsList: widget.accountsList,
          dataInput: (dataInput) {
            setState(() {
              inputMyData = dataInput;
            });
          },
        ),
        BlocBuilder<DailyFrenchCashCubit, DailyFrenchCashState>(
          builder: (context, state) {
            if (state is DailyFrenchCashLoading) {
              return const CustomLoadingWidget();
            } else if (state is DailyFrenchCashFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is DailyFrenchCashSuccess) {
              return Text("SUCCESS");
            } else {
              return Text("OFF");
            }
          },
        )
      ],
    );
  }
}
