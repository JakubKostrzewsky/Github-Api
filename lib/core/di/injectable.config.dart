// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:github/core/di/modules/network_manager_module.dart' as _i677;
import 'package:github/features/github/data/api/github_api.dart' as _i89;
import 'package:github/features/github/data/repositories/repositories_repository_impl.dart' as _i444;
import 'package:github/features/github/domain/repositories/repositories_repository.dart' as _i286;
import 'package:github/features/github/domain/usecases/get_repositories_usecase.dart' as _i43;
import 'package:github/features/github/domain/usecases/get_repository_details_usecase.dart' as _i209;
import 'package:github/features/github/presentation/cubits/repositories/repositories_cubit.dart' as _i952;
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_cubit.dart' as _i463;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkManagerModule = _$NetworkManagerModule();
    gh.lazySingleton<_i361.Dio>(() => networkManagerModule.dio());
    gh.factory<_i89.GitHubApi>(() => _i89.GitHubApi(gh<_i361.Dio>()));
    gh.factory<_i286.RepositoriesRepository>(() => _i444.RepositoriesRepositoryImpl(gh<_i89.GitHubApi>()));
    gh.factory<_i43.GetRepositoriesUseCase>(() => _i43.GetRepositoriesUseCase(gh<_i286.RepositoriesRepository>()));
    gh.factory<_i209.GetRepositoryDetailsUseCase>(
        () => _i209.GetRepositoryDetailsUseCase(gh<_i286.RepositoriesRepository>()));
    gh.factory<_i952.RepositoriesCubit>(() => _i952.RepositoriesCubit(gh<_i43.GetRepositoriesUseCase>()));
    gh.factory<_i463.RepositoryDetailsCubit>(
        () => _i463.RepositoryDetailsCubit(gh<_i209.GetRepositoryDetailsUseCase>()));
    return this;
  }
}

class _$NetworkManagerModule extends _i677.NetworkManagerModule {}
