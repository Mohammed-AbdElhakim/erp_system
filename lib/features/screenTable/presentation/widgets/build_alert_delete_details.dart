import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../manager/delete/delete_cubit.dart';

typedef OnTapDelete<T> = void Function();

class BuildAlertDeleteDetails extends StatefulWidget {
  const BuildAlertDeleteDetails({super.key, required this.onTapDelete});

  final OnTapDelete<Map<String, dynamic>> onTapDelete;
  @override
  State<BuildAlertDeleteDetails> createState() =>
      _BuildAlertDeleteDetailsState();
}

class _BuildAlertDeleteDetailsState extends State<BuildAlertDeleteDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<DeleteCubit, DeleteState>(
          listener: (context, state) {
            if (state is DeleteSuccess) {
              Navigator.pop(context);
            } else if (state is DeleteFailure) {
              CustomAlertDialog.alertWithButton(
                  context: context,
                  type: AlertType.error,
                  title: S.of(context).error,
                  textButton: S.of(context).ok,
                  desc: state.errorMassage,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            if (state is DeleteLoading) {
              return const CustomLoadingWidget();
            } else {
              return CustomButton(
                text: S.of(context).btn_delete,
                width: 80,
                onTap: () {
                  widget.onTapDelete();
                },
              );
            }
          },
        ),
      ],
    );
  }
}
