part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class CounterGetAdminCountInitial extends CounterState {}

class CounterGetAdminCountError extends CounterState {
  final AppBaseResponse response;

  CounterGetAdminCountError(this.response);
}

class CounterGetAdminCountSuccess extends CounterState {
  final List<CounterModel> response;
  CounterGetAdminCountSuccess(this.response);
}
