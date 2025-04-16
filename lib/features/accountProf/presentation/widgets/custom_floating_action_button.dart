import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/file_excel_by_data.dart';
import '../../../../core/widgets/file_pdf_by_data.dart';
import '../manager/accountProf/account_prof_cubit.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.data,
    required this.pageData,
    required this.selectTab,
    required this.link,
  });

  final Map<String, dynamic> data;
  final Pages pageData;
  final int selectTab;
  final String link;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  String? lang;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool shouldReopenDial = true;
  List<dynamic> listKey = [];

  List<IconData> iconList = [
    Icons.refresh,
    // Icons.print,
    FontAwesomeIcons.fileExcel,
    FontAwesomeIcons.filePdf,
  ];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: AppColors.blueLight,
      overlayOpacity: 0.5,
      openCloseDial: isDialOpen,
      closeManually: true,
      activeIcon: Icons.close,
      iconTheme: IconThemeData(color: AppColors.white),
      buttonSize: const Size(58, 58),
      curve: Curves.easeIn,
      children: List.generate(
        iconList.length,
        (index) => SpeedDialChild(
            elevation: 0,
            backgroundColor: getColor(iconList[index]),
            shape: const CircleBorder(),
            child: Icon(
              iconList[index],
              color: AppColors.white,
            ),
            onTap: () {
              tapIcon(iconList[index]);
              isDialOpen.value = false;
            }),
      ),
      child: Icon(
        Icons.settings,
        color: AppColors.white,
      ),
    );
  }

  getColor(IconData icon) {
    if (icon == Icons.refresh) {
      return AppColors.orange;
    } else if (icon == FontAwesomeIcons.fileExcel) {
      return AppColors.blueLight;
    } else if (icon == FontAwesomeIcons.filePdf) {
      return AppColors.red;
    } else if (icon == Icons.print) {
      return AppColors.green;
    }
  }

  void tapIcon(IconData icon) {
    if (icon == Icons.refresh) {
      // BlocProvider.of<GetHeaderTableCubit>(context)
      //     .getHeaderTable(listName: widget.data['listName']);
      BlocProvider.of<AccountProfCubit>(context).getTableAccountProf(
        objectData: widget.data,
        numberOfPage: 1,
        dropdownValueOfLimit: 10,
      );
    } else if (icon == FontAwesomeIcons.fileExcel) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: FileExcelByData(
            pageData: widget.pageData,
            lang: lang!,
            data: widget.data,
            tabIndex: widget.selectTab,
            link: widget.link,
          ),
        ),
      );
    } else if (icon == FontAwesomeIcons.filePdf) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: FilePdfByData(
            pageData: widget.pageData,
            lang: lang!,
            data: widget.data,
            tabIndex: widget.selectTab,
            link: widget.link,
          ),
        ),
      );
    } else if (icon == Icons.print) {
      // List<dynamic> myRowData = ScreenTable.rowData;
      // if (myRowData.isNotEmpty) {
      //   if (myRowData.length > 1) {
      //     CustomAlertDialog.alertWithButton(
      //         context: context,
      //         type: AlertType.error,
      //         title: S.of(context).error,
      //         desc: S.of(context).massage_no_print);
      //   } else if (myRowData.length == 1) {
      //     showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (context) => AlertDialog(
      //         content: PrintRow(
      //           pageData: widget.pageData,
      //           lang: lang!,
      //           id: int.parse(ScreenTable.rowData[0].toString()),
      //         ),
      //       ),
      //     );
      //   }
      // } else {
      //   CustomAlertDialog.alertWithButton(
      //       context: context,
      //       type: AlertType.error,
      //       title: S.of(context).error,
      //       desc: S.of(context).massage_choose_print);
      // }
    }
  }
}
