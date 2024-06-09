part of 'get_list_setups_cubit.dart';

sealed class GetListSetupsState extends Equatable {
  const GetListSetupsState();
}

final class GetListSetupsInitial extends GetListSetupsState {
  @override
  List<Object> get props => [];
}
