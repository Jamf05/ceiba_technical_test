import 'package:bloc/bloc.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/overlay/custom_overlays.dart';
import 'package:ceiba_technical_test/core/validators/text_input.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_data_usecase.dart';
import 'package:ceiba_technical_test/features/domain/usecases/register_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserDataUseCase _getUserUseCase;
  final SetUserUseCase _setUserUseCase;

  HomeBloc({
    required GetUserDataUseCase getUserUseCase,
    required SetUserUseCase setUserUseCase,
  })  : _getUserUseCase = getUserUseCase,
        _setUserUseCase = setUserUseCase,
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
    filteredList = _userList.where((e) => e.name?.contains(v.value) == true).toList();
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
    add(const HomeLoadingEvent());
    await Future.delayed(const Duration(seconds: 1));
    // final response = await _getUserUseCase.call(NoParams());
    // response.fold((l) => emit(HomeFailureState(l)), (r) {
    //   user = r ?? user;
    //   name = name.copyWith(user.name ?? '');
    //   surname = surname.copyWith(user.surname ?? '');
    //   birthdayDate = user.birthday;
    //   addressTextEditingCtrl.text = user.address?.name ?? '';
    // });
    isLoadingPage = false;
    add(const HomeLoadingEvent());
  }
}
