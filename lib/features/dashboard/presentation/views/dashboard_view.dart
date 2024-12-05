import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/features/dashboard/presentation/manager/dashboard/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../../data/repositories/dashboard_repo_impl.dart';
import '../widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(
        getIt.get<DashboardRepoImpl>(),
      )..getDashboard(),
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          title: S.of(context).dashboard,
          isTitleInPortrait: true,
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              BlocProvider.of<DashboardCubit>(context).getDashboard();
            },
            backgroundColor: AppColors.blueLight,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          );
        }),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardSuccess) {
              List<Map<String, dynamic>> listData = [];
              for (var element
                  in state.dashboardModel.list.percentageSections) {
                listData.add(element.toJson());
              }
              for (var element in state.dashboardModel.list.numbersSections) {
                listData.add(element.toJson());
              }
              for (var element in state.dashboardModel.list.newsSections) {
                listData.add(element.toJson());
              }
              for (var element in state.dashboardModel.list.graphSections) {
                listData.add(element.toJson());
              }
              for (var element in state.dashboardModel.list.tablesSections) {
                listData.add(element.toJson());
              }

              listData.sort(
                  (a, b) => a["SectionOrder"].compareTo(b["SectionOrder"]));
              return DashboardViewBody(
                listData: listData,
              );
            } else if (state is DashboardFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
