import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final LatLng? geo;
  const AddressEntity({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipcode,
        geo,
      ];
}