import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/company/repository/company_repository.dart';

part 'list_articles_state.dart';

class ListArticlesCubit extends Cubit<ListArticlesState> {
  ListArticlesCubit(this.companyRepository) : super(const ListArticlesState());
  final CompanyRepository companyRepository;
  void getCompanies() {
    //companyRepository.saveCompany(description)
  }
}
