import 'package:erp_system/core/models/menu_model/pages.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/cashier_repo_impl.dart';
import '../manager/getFileWordPrint/get_file_word_print_cubit.dart';

class PrintInvoice extends StatelessWidget {
  final Pages pageData;
  final String lang;
  final int id;

  const PrintInvoice({
    super.key,
    required this.pageData,
    required this.lang,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFileWordPrintCubit(
        getIt.get<CashierRepoImpl>(),
      )..getFileWordPrint(pageData: pageData, id: id),
      child: BlocConsumer<GetFileWordPrintCubit, GetFileWordPrintState>(
        listener: (BuildContext context, GetFileWordPrintState state) async {
          if (state is GetFileWordPrintSuccess) {
            Navigator.pop(context);

            try {
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async {
                  return state.wordData;
                },
              );
            } catch (e) {
              if (kDebugMode) {
                print("Error printing PDF: $e");
              }
            }

            // Printing.layoutPdf(
            //   onLayout: (format) async => state.wordData,
            // );
            // showSnackBar(context: context,message: massage,);
          }
        },
        builder: (context, state) {
          if (state is GetFileWordPrintFailure) {
            if (state.errorMassage == "\"Bad Request\"") {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).no_print_file,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.red),
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                    text: S.of(context).ok,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            } else {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            }
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).preparing_print_file,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.blueLight),
                ),
                const SizedBox(height: 8),
                const CustomLoadingWidget()
              ],
            );
          }
        },
      ),
    );
  }
}
