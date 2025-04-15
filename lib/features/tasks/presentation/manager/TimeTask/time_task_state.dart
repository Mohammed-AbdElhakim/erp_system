part of 'time_task_cubit.dart';


sealed class TimeTaskState extends Equatable {
  const TimeTaskState();
  @override
  List<Object> get props => [];
}

final class TimeTaskInitial extends TimeTaskState {}

final class TimeTaskLoading extends TimeTaskState {}

final class TimeTaskFailure extends TimeTaskState {
  final String errorMassage;

  const TimeTaskFailure(this.errorMassage);
}


final class AllTimeTaskSuccess extends TimeTaskState {
  final List<AllTimeModel> allTimeModelList;

  const AllTimeTaskSuccess(this.allTimeModelList);
}


final class AddTimeTaskSuccess extends TimeTaskState {
  final AddNewTimeModel addNewTimeModel;

  const AddTimeTaskSuccess(this.addNewTimeModel);
}
final class DeleteTimeTaskSuccess extends TimeTaskState {
}