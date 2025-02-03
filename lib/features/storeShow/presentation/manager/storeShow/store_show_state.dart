part of 'store_show_cubit.dart';

sealed class StoreShowState extends Equatable {
  const StoreShowState();
  @override
  List<Object> get props => [];
}

final class StoreShowInitial extends StoreShowState {}

final class StoreShowLoading extends StoreShowState {}

final class StoreShowFailure extends StoreShowState {
  final String errorMassage;

  const StoreShowFailure(this.errorMassage);
}

final class StoreShowSuccess extends StoreShowState {
  final StoreShowModel storeShowModel;
  final int numberPage;
  final int dropdownValue;

  const StoreShowSuccess(
      {required this.storeShowModel,
      required this.numberPage,
      required this.dropdownValue});
}
