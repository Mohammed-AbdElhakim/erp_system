import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/manager/getDataGlobal/get_data_global_cubit.dart';
import '../../../../core/repositories/general/general_repo_impl.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../data/models/money_account_model.dart';

class CashMoneyViewBody extends StatefulWidget {
  const CashMoneyViewBody({super.key});

  @override
  State<CashMoneyViewBody> createState() => _CashMoneyViewBodyState();
}

class _CashMoneyViewBodyState extends State<CashMoneyViewBody> {
  final Map<String, dynamic> bodyRequest = {"tableName": "MonyAccount"};

//getIt.get<GeneralRepoImpl>()
  @override
  Widget build(BuildContext context) {
    return Container();
    // return BlocProvider(
    //   create: (context) => GetDataGlobalCubit(getIt.get<GeneralRepoImpl>())..getDataGlobal(bodyRequest: bodyRequest),
    //   child: Column(
    //     children: [
    //       CustomDropdownList<MoneyAccountList>(
    //         title: '',
    //         onTapRefresh: () {},
    //         listData: const [],
    //       )
    //     ],
    //   ),
    // );
  }
}
