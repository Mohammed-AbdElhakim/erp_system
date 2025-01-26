import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../manager/profileData/profile_data_cubit.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: S.of(context).profile,
        isTitleInLandscape: false,
      ),
      body: BlocProvider(
        create: (context) =>
            ProfileDataCubit(getIt.get<ProfileRepoImpl>())..getProfileData(),
        child: BlocBuilder<ProfileDataCubit, ProfileDataState>(
          builder: (context, state) {
            if (state is ProfileDataSuccess) {
              return ProfileViewBody(
                profileModel: state.profileModel,
              );
            } else if (state is ProfileDataFailure) {
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
