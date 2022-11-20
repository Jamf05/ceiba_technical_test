import 'package:ceiba_technical_test/features/data/datasource/address_local_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/address_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AddressRepository,
  AddressLocalDataSource,
], customMocks: [])
void main() {}
