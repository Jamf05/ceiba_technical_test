import 'package:ceiba_technical_test/core/types/mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';

class AddressMapper implements Mapper<AddressEntity> {
  @override
  AddressEntity fromJson(Map<String, dynamic>? json) => AddressEntity(
        street: json?["street"],
        suite: json?["suite"],
        city: json?["city"],
        zipcode: json?["zipcode"],
        geo: LatLng(double.tryParse((json?["geo"]["lat"]).toString()),
            double.tryParse((json?["geo"]["lng"]).toString())),
      );

  @override
  Map<String, dynamic> toJson(AddressEntity? object) {
    return {
      "street": object?.street,
      "suite": object?.suite,
      "city": object?.city,
      "zipcode": object?.zipcode,
      "geo": {
        "lat": object?.geo?.lat.toString(),
        "lng": object?.geo?.lng.toString(),
      },
    };
  }
}
