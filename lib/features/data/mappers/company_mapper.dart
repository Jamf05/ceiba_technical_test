import 'package:ceiba_technical_test/core/types/mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/company_entity.dart';

class CompanyMapper implements Mapper<CompanyEntity> {
  @override
  CompanyEntity fromJson(Map<String, dynamic>? json) => CompanyEntity(
        name: json?["name"] ,
        catchPhrase: json?["catchPhrase"],
        bs: json?["bs"],
      );

  @override
  Map<String, dynamic> toJson(CompanyEntity? object) {
    return {
      "name": object?.name,
      "catchPhrase": object?.catchPhrase,
      "bs": object?.bs,
    };
  }
}
