part of 'tax_declaration_cubit.dart';

sealed class TaxDeclarationState extends Equatable {
  const TaxDeclarationState();
  @override
  List<Object> get props => [];
}

final class TaxDeclarationInitial extends TaxDeclarationState {}

final class TaxDeclarationLoading extends TaxDeclarationState {}

final class TaxDeclarationFailure extends TaxDeclarationState {
  final String errorMassage;

  const TaxDeclarationFailure(this.errorMassage);
}

final class TaxDeclarationSuccess extends TaxDeclarationState {
  final dynamic taxDeclarationModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const TaxDeclarationSuccess({
    required this.taxDeclarationModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
