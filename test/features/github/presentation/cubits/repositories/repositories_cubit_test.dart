import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/domain/usecases/get_repositories_usecase.dart';
import 'package:github/features/github/presentation/cubits/repositories/repositories_cubit.dart';
import 'package:github/features/github/presentation/cubits/repositories/repositories_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/test_data.dart';

import 'repositories_cubit_test.mocks.dart';

@GenerateMocks([GetRepositoriesUseCase])
void main() {
  group('RepositoriesCubit', () {
    late RepositoriesCubit cubit;
    late MockGetRepositoriesUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGetRepositoriesUseCase();
      cubit = RepositoriesCubit(mockUseCase);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be RepositoriesInitial', () {
      expect(cubit.state, const RepositoriesInitial());
    });

    group('searchRepositories', () {
      const query = 'flutter';
      final mockRepositories = TestData.repositories;

      blocTest<RepositoriesCubit, RepositoriesState>(
        'emits [RepositoriesLoading, RepositoriesLoaded] when search is successful',
        build: () {
          when(mockUseCase(query)).thenAnswer((_) async => mockRepositories);
          return cubit;
        },
        act: (cubit) => cubit.searchRepositories(query),
        expect: () => [
          const RepositoriesLoading(),
          RepositoriesLoaded(repositories: mockRepositories, query: query),
        ],
        verify: (_) {
          verify(mockUseCase(query)).called(1);
        },
      );

      blocTest<RepositoriesCubit, RepositoriesState>(
        'emits [RepositoriesLoading, RepositoriesError] when search fails',
        build: () {
          when(mockUseCase(query)).thenThrow(Exception('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.searchRepositories(query),
        expect: () => [
          const RepositoriesLoading(),
          const RepositoriesError('Exception: Network error'),
        ],
        verify: (_) {
          verify(mockUseCase(query)).called(1);
        },
      );

      blocTest<RepositoriesCubit, RepositoriesState>(
        'emits [RepositoriesInitial] when query is empty',
        build: () => cubit,
        act: (cubit) => cubit.searchRepositories(''),
        expect: () => [const RepositoriesInitial()],
        verify: (_) {
          verifyNever(mockUseCase(any));
        },
      );

      blocTest<RepositoriesCubit, RepositoriesState>(
        'emits [RepositoriesInitial] when query is whitespace only',
        build: () => cubit,
        act: (cubit) => cubit.searchRepositories('   '),
        expect: () => [const RepositoriesInitial()],
        verify: (_) {
          verifyNever(mockUseCase(any));
        },
      );
    });
  });
}
