import 'package:bloc/bloc.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/overlay/custom_overlays.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/core/validators/text_input.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_list_use_case.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserListUseCase _getUserUseCase;

  HomeBloc({
    required GetUserListUseCase getUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        super(const HomeInitial()) {
    on<GetUserDataEvent>(_mapGetUserDataEventToState);
    on<HomeLoadingEvent>(_mapHomeLoadingEventToState);
  }

  bool isLoadingPage = true;
  bool sendingData = false;
  List<UserEntity> _userList = [];
  List<UserEntity> filteredList = [];

  TextFormInput _query = const TextFormInput.dirty("", start: 0, end: 15);
  TextFormInput get query => _query;
  set query(TextFormInput v) {
    _query = v;
    filteredList =
        _userList.where((e) => e.name?.toLowerCase().contains(v.value.toLowerCase()) == true).toList();
    add(const HomeLoadingEvent());
  }

  void _mapHomeLoadingEventToState(
      HomeLoadingEvent event, Emitter<HomeState> emit) async {
    emit(const HomeInitial());
    emit(const HomeLoadingState());
  }

  void _mapGetUserDataEventToState(
      GetUserDataEvent event, Emitter<HomeState> emit) async {
    isLoadingPage = true;
    emit(const HomeInitial());
    emit(const HomeLoadingState());
    final response = await _getUserUseCase.call(NoParams());
    response.fold((l) => emit(HomeFailureState(l)), (r) {
      _userList = r ?? [];
      filteredList = _userList;
    });
    isLoadingPage = false;
    emit(const HomeInitial());
    emit(const HomeLoadingState());
  }
}
