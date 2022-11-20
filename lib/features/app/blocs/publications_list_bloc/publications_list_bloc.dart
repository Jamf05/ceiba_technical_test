import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'publications_list_event.dart';
part 'publications_list_state.dart';

class PublicationsListBloc extends Bloc<PublicationsListEvent, PublicationsListState> {
  PublicationsListBloc() : super(PublicationsListInitial()) {
    on<PublicationsListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
