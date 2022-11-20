import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    LatLng? geo,
  }) : super(
          street: street,
          suite: suite,
          city: city,
          zipcode: zipcode,
          geo: geo,
        );

  factory AddressModel.cast(AddressEntity? e) {
    return AddressModel(
      street: e?.street,
      suite: e?.suite,
      city: e?.city,
      zipcode: e?.zipcode,
      geo: e?.geo,
    );
  }

  AddressModel copyWithModel({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    LatLng? geo,
  }) {
    return AddressModel(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: LatLng(double.tryParse(json["lat"].toString()),
            double.tryParse(json["lng"].toString())),
      );
}
