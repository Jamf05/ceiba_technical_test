import 'package:equatable/equatable.dart';

class LatLng extends Equatable {
  final double? lat;
  final double? lng;
  const LatLng(this.lat, this.lng);
  
  @override
  List<Object?> get props => [lat, lng];
}