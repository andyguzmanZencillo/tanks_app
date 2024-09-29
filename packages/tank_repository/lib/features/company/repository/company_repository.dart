import 'package:failures/failures.dart';
import 'package:oxidized/oxidized.dart';
import 'package:tank_api/features/company/api/company_api.dart';
import 'package:tank_api/features/company/models/company_request.dart';
import 'package:tank_repository/core/generic_token.dart';

class CompanyRepository {
  CompanyRepository({
    CompanyApi? api,
  }) : _api = api ?? CompanyApi();

  final CompanyApi _api;

  Future<Result<Unit, Failure>> saveCompany(String description) {
    return handleExceptionToken<Unit>(() async {
      final request = InsertCompanyRequest(descripcion: description);
      await _api.saveCompany(request);
      return unit;
    });
  }

  /*Future<Result<Unit, Failure>> getCompanies() {
    return handleExceptionToken<Unit>(() async {
      final request = InsertCompanyRequest(descripcion: description);
      await _api.saveCompany(request);
      return unit;
    });
  }*/
}
