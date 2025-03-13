part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object> get props => [];
}

class UpdateButtonEvent extends HomeEvent {}

class GetUserDataEvent extends HomeEvent {
  const GetUserDataEvent();
}

class HomeLoadingEvent extends HomeEvent {
  const HomeLoadingEvent();
}
