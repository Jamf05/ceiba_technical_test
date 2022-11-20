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

  AddressEntity copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    LatLng? geo,
  }) {
    return AddressEntity(
      street: street ?? this.street,
      suite: suite ?? this.suite,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      geo: geo ?? this.geo,
    );
  }

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipcode,
        geo,
      ];
}