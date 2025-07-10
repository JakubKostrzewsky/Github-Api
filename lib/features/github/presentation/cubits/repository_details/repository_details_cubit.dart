import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github/features/github/domain/usecases/get_repository_details_usecase.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class RepositoryDetailsCubit extends Cubit<RepositoryDetailsState> {
  RepositoryDetailsCubit(this._getRepositoryDetailsUseCase) : super(const RepositoryDetailsLoading());

  final GetRepositoryDetailsUseCase _getRepositoryDetailsUseCase;

  Future<void> loadRepositoryDetails({
    required String owner,
    required String repo,
  }) async {
    emit(const RepositoryDetailsLoading());
    try {
      final details = await _getRepositoryDetailsUseCase(owner, repo);
      emit(RepositoryDetailsLoaded(details));
    } catch (e) {
      emit(RepositoryDetailsError(e.toString()));
    }
  }
}
