part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}


class HomeFailureState extends HomeState {
  final Failure failure;
  const HomeFailureState(this.failure);
  @override
  List<Object> get props => [failure];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}
