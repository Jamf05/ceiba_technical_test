import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/enums/session_status.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? surname;
  final AddressEntity? address;
  final DateTime? birthday;
  final SessionStatus status = SessionStatus.inactive;

  const UserEntity(
      {this.id, this.name, this.surname, this.address, this.birthday});

  UserEntity copyWith({
    int? id,
    String? name,
    String? surname,
    AddressEntity? address,
    DateTime? birthday,
  }) {
    return UserEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        address: address ?? this.address,
        birthday: birthday ?? this.birthday);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        address,
        birthday,
      ];
}
