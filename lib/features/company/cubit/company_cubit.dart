import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/company/repository/company_repository.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit(this.companyRepository) : super(const CompanyState());
  final CompanyRepository companyRepository;

  Future<bool> saveCompany() async {
    final result = await companyRepository.saveCompany('sada');
    result.when(
      ok: (ok) {},
      err: (err) {},
    );

    return result.isOk();
  }
}
