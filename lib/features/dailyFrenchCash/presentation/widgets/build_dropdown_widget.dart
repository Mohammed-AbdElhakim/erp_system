import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/accounts_model.dart';

class BuildDropdownWidget extends StatefulWidget {
  const BuildDropdownWidget({super.key, required this.accountsList});
  final List<AccountsList> accountsList;

  @override
  State<BuildDropdownWidget> createState() => _BuildDropdownWidgetState();
}

class _BuildDropdownWidgetState extends State<BuildDropdownWidget> {
  List<int> accountIdList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                S.of(context).account,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              // const SizedBox(
              //   width: 12,
              // ),
              // InkWell(
              //   onTap: () async {
              //     BlocProvider.of<AccountsCubit>(context).getAccountsList();
              //   },
              //   child: const Icon(
              //     Icons.refresh,
              //     color: Colors.green,
              //     size: 24,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 40,
            child: CustomDropdown<AccountsList>.multiSelectSearch(
              hintText: '',
              onListChanged: (valueList) {
                setState(() {
                  accountIdList = valueList.cast<int>();
                });
              },
              // initialItem: dropValue,
              closedHeaderPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: CustomDropdownDecoration(
                headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                closedFillColor: Colors.transparent,
                closedBorder: Border.all(color: AppColors.blueDark),
              ),
              items: widget.accountsList,
            ),
          )
        ],
      ),
    );
  }
}
