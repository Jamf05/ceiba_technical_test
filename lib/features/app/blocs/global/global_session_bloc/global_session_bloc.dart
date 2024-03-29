import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';

part 'global_session_event.dart';
part 'global_session_state.dart';

class GlobalSessionBloc extends Bloc<GlobalSessionEvent, GlobalSessionState> {
  GlobalSessionBloc() : super(GlobalSessionBlocInitial());
  UserEntity? user;
}
