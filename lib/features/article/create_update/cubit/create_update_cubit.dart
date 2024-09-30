import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tank_repository/features/article/repository/article_repository.dart';

part 'create_update_state.dart';

class CreateUpdateCubit extends Cubit<CreateUpdateState> {
  CreateUpdateCubit(this.articleRepository) : super(const CreateUpdateState());
  final ArticleRepository articleRepository;
}
