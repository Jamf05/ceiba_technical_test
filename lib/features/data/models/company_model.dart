import 'package:ceiba_technical_test/features/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    String? name,
    String? catchPhrase,
    String? bs,
  }) : super(
    name: name,
    catchPhrase: catchPhrase,
    bs: bs,
  );

  factory CompanyModel.cast(CompanyEntity? e) {
    return CompanyModel(
      name: e?.name,
      catchPhrase: e?.catchPhrase,
      bs: e?.bs,
    );
  }
  
  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
    );
}
