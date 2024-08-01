import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/manager/getMenu/get_menu_cubit.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../core/widgets/page_item_grid_view.dart';
import '../../../../generated/l10n.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key, required this.isPortrait});
  final bool isPortrait;
  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  // @override
  // void initState() {
  //   BlocProvider.of<DashboardCubit>(context).getDashboardData();
  //   super.initState();
  // }

  List<Pages> pagesListSearch = [];
  TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<Pages> pagesList = [];
          for (var element in state.menu.list) {
            for (var page in element.pages) {
              if (page.url == "chart") {
                pagesList.add(page);
              }
            }
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 35, top: 35),
                  child: CustomTextFormFieldSearch(
                    hintText: S.of(context).search,
                    controller: controllerSearch,
                    onChanged: (value) {
                      pagesListSearch = pagesList
                          .where((page) => page.nameAr.contains(value))
                          .toList();
                      setState(() {});
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controllerSearch.text.isNotEmpty
                      ? pagesListSearch.isEmpty
                          ? 0
                          : pagesListSearch.length
                      : pagesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.isPortrait ? 3 : 5,
                    mainAxisSpacing: 35,
                    crossAxisSpacing: 35,
                    // mainAxisExtent: MediaQuery.of(context).size.width * .25,
                    // childAspectRatio: MediaQuery.of(context).size.width * .5,
                  ),
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return PageItemGridView(
                        page: controllerSearch.text.isNotEmpty
                            ? pagesListSearch[index]
                            : pagesList[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state is GetMenuFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
