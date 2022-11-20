import 'package:ceiba_technical_test/features/data/models/address_model.dart';
import 'package:ceiba_technical_test/features/data/models/company_model.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? name,
    String? username,
    String? email,
    AddressModel? address,
    String? phone,
    String? website,
    CompanyModel? company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address,
          phone: phone,
          website: website,
          company: company,
        );

  factory UserModel.cast(UserEntity? e) {
    return UserModel(
      id: e?.id,
      name: e?.name,
      username: e?.username,
      email: e?.email,
      address: AddressModel.cast(e?.address),
      phone: e?.phone,
      website: e?.website,
      company: CompanyModel.cast(e?.company),
    );
  }

  UserModel copyWithModel({
    int? id,
    String? name,
    String? username,
    String? email,
    AddressModel? address,
    String? phone,
    String? website,
    CompanyModel? company,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? AddressModel.cast(this.address),
      phone: phone ?? this.phone,
      website: website ?? this.website,
      company: company ?? CompanyModel.cast(this.company),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: AddressModel.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: CompanyModel.fromJson(json["company"]),
    );

  factory UserModel.fromQuery(Map<String, dynamic> query) {
    return UserModel(
      id: int.tryParse(query["id"].toString()),
      name: query["name"],
      username: query["username"],
      email: query["email"],
      phone: query["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
