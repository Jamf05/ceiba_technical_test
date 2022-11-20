import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int? id;
  final bool? selected;
  final String? name;
  const AddressEntity({this.id, this.selected = false, this.name = ""});

  AddressEntity copyWith({
    int? id,
    bool? selected,
    String? name,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      selected: selected ?? this.selected,
      name: name ?? this.name,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        selected,
        name,
      ];
}
