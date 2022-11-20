import 'package:equatable/equatable.dart';

class CompanyEntity extends Equatable {
  final String? name;
  final String? catchPhrase;
  final String? bs;

  const CompanyEntity({this.name, this.catchPhrase, this.bs});

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}
