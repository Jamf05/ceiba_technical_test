part of 'publications_list_bloc.dart';

abstract class PublicationsListState extends Equatable {
  const PublicationsListState();
  
  @override
  List<Object> get props => [];
}

class PublicationsListInitial extends PublicationsListState {}
