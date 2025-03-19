import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/features/dailyFrenchCash/data/models/body_request_daily_french_cash.dart';
import 'package:erp_system/features/dailyFrenchCash/presentation/manager/dailyFrenchCash/daily_french_cash_cubit.dart';
import 'package:erp_system/features/dailyFrenchCash/presentation/widgets/build_radio_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../data/models/accounts_model.dart';
import 'build_date_widget.dart';
import 'build_dropdown_widget.dart';

class BuildDailyFrenchCashInput extends StatefulWidget {
  const BuildDailyFrenchCashInput(
      {super.key, required this.accountsList, required this.dataInput});
  final List<AccountsList> accountsList;
  final void Function(BodyRequestDailyFrenchCash dataInput) dataInput;

  @override
  State<BuildDailyFrenchCashInput> createState() => _BuildDailyFrenchCashInputState();
}

class _BuildDailyFrenchCashInputState extends State<BuildDailyFrenchCashInput> {
  String dateFrom = '', dateTo = '';
  List<int> listOfId = [];
  bool selectType = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              BuildDateWidget(
                title: S.of(context).date_from,
                selectedDate: (dateTime) {
                  setState(() {
                    dateFrom = dateTime;
                  });
                },
              ),
              const SizedBox(width: 8),
              BuildDateWidget(
                title: S.of(context).date_to,
                selectedDate: (dateTime) {
                  setState(() {
                    dateTo = dateTime;
                  });
                },
              ),
            ],
          ),
          BuildDropdownWidget(
            accountsList: widget.accountsList,
            selectedList: (idList) {
              setState(() {
                listOfId = idList;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BuildRadioButtonsWidget(
                  selectedType: (type) {
                    if (type == "incoming") {
                      setState(() {
                        selectType = true;
                      });
                      makeRequest(context);
                    } else if (type == "outgoing") {
                      setState(() {
                        selectType = false;
                      });
                      makeRequest(context);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: FloatingActionButton(
                  backgroundColor: AppColors.blueLight,
                  shape: const CircleBorder(),
                  mini: true,
                  onPressed: () {
                    makeRequest(context);
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void makeRequest(BuildContext context) {
    BodyRequestDailyFrenchCash bodyRequestDailyFrenchCash = BodyRequestDailyFrenchCash(
      accountId: listOfId,
      creditOrDepit: selectType,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
    widget.dataInput(bodyRequestDailyFrenchCash);
    BlocProvider.of<DailyFrenchCashCubit>(context)
        .getDailyFrenchCash(bodyRequestDailyFrenchCash: bodyRequestDailyFrenchCash);
  }
}
