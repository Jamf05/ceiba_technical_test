import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/company_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final AddressEntity? address;
  final String? phone;
  final String? website;
  final CompanyEntity? company;

  const UserEntity({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        address,
        phone,
        website,
        company,
      ];
}
