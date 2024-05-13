import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../manager/getMenu/get_menu_cubit.dart';
import 'home_view_header.dart';
import 'item_grid_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.isPortrait});

  final bool isPortrait;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  List<Pages> pagesList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<Pages> pagesListInFastScreen = [];
          List<Pages> allPagesList = [];
          for (var element in state.menu.list) {
            for (var page in element.pages) {
              allPagesList.add(page);
              if (page.isFastScreen == true) {
                pagesListInFastScreen.add(page);
              }
            }
          }
          return CustomScrollView(
            slivers: [
              widget.isPortrait
                  ? const SliverToBoxAdapter(
                      child: HomeViewHeader(),
                    )
                  : const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 35),
                  child: CustomTextFormFieldSearch(
                    hintText: S.of(context).search,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        pagesList = pagesListInFastScreen;
                        setState(() {});
                      } else {
                        pagesList = allPagesList
                            .where((page) => page.nameAr.contains(value))
                            .toList();
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: pagesList.isEmpty
                      ? pagesListInFastScreen.length
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
                    return ItemGridView(
                      page: pagesList.isEmpty
                          ? pagesListInFastScreen[index]
                          : pagesList[index],
                    );
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
