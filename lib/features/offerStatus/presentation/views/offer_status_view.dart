import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/offerStatus/presentation/widgets/offer_status_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/offer_master_model.dart';
import '../../data/repositories/offer_master_repo_impl.dart';
import '../manager/getOfferMaster/get_offer_master_cubit.dart';

String listNoState = "NOStats";

class OfferStatusView extends StatefulWidget {
  const OfferStatusView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<OfferStatusView> createState() => _OfferStatusViewState();
}

class _OfferStatusViewState extends State<OfferStatusView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          isTitleInPortrait: true,
          title: lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
        ),
        body: BlocProvider(
          create: (context) => GetOfferMasterCubit(getIt.get<OfferMasterRepoImpl>())..getOfferMaster(),
          child: BlocBuilder<GetOfferMasterCubit, GetOfferMasterState>(
            builder: (context, state) {
              if (state is GetOfferMasterSuccess) {
                // final data = convertToCategorizedLists(state.offerMasterModel);
                // final data = {
                //   "أرقام": ["100", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                //   "أسماء": ["Ali", "Mohamed", "Ahmed", "Sami", "Osama"],
                //   "فاكهة": ['تفاح', 'موز', 'عنب', 'برتقال', 'فراولة', 'مانجو'],
                //   "مشروبات": ['ماء', 'عصير برتقال', 'شاي', 'قهوة', 'بيبسي', 'ليمون بالنعناع'],
                //   "خضار": ['خس', 'جزر', 'طماطم', 'خيار', 'فلفل', 'بطاطس'],
                //   "حلويات": ['كعكة', 'بسبوسة', 'آيس كريم', 'كنافة', 'مهلبية', 'تيراميسو'],
                // };
                final offersMap = buildOffersMap(state.offerMasterModel, useArabic: lang == AppStrings.arLangKey ? true : false);

                return OfferStatusViewBody(
                  data: offersMap,
                  states: state.offerMasterModel.states ?? [],
                );
              } else if (state is GetOfferMasterFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else if (state is GetOfferMasterLoading) {
                return const CustomLoadingWidget();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Map<String, List<Offers>> buildOffersMap(OfferMasterModel model, {bool useArabic = true}) {
    final Map<String, List<Offers>> offersMap = {};
    offersMap[listNoState] = model.offerNOStats ?? [];
    for (final state in model.states ?? []) {
      final key = useArabic ? state.arName : state.enName;
      if (key != null) {
        offersMap[key] = state.offers ?? [];
      }
    }

    return offersMap;
  }
}
