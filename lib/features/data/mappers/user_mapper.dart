import 'package:ceiba_technical_test/core/types/mapper.dart';
import 'package:ceiba_technical_test/features/data/mappers/address_mapper.dart';
import 'package:ceiba_technical_test/features/data/mappers/company_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';

class UserMapper implements Mapper<UserEntity> {
  @override
  UserEntity fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: AddressMapper().fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: CompanyMapper().fromJson(json["company"]),
      );

  UserEntity fromQuery(Map<String, dynamic> query) {
    return UserEntity(
      id: int.tryParse(query["id"].toString()),
      name: query["name"],
      username: query["username"],
      email: query["email"],
      phone: query["phone"],
    );
  }

  @override
  Map<String, dynamic> toJson(UserEntity? object) {
    return {
      "id": object?.id,
      "name": object?.name,
      "username": object?.username,
      "email": object?.email,
      "address": AddressMapper().toJson(object?.address),
      "phone": object?.phone,
      "website": object?.website,
      "company": CompanyMapper().toJson(object?.company),
    };
  }
}
