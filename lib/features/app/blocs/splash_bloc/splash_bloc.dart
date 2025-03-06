import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckAuthenticatedEvent>(_mapCheckAuthenticatedToState);
    on<RejectUserConfirmationEvent>(_mapRejectUserConfirmationToState);
  }

  void _mapCheckAuthenticatedToState(
      CheckAuthenticatedEvent event, Emitter<SplashState> emit) async {
    emit(CheckAuthenticatedState());
  }

  void _mapRejectUserConfirmationToState(
      RejectUserConfirmationEvent event, Emitter<SplashState> emit) async {
    emit(RejectUserConfirmationState());
  }
}
