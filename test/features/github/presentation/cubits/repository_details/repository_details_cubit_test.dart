import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/domain/usecases/get_repository_details_usecase.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_cubit.dart';
import 'package:github/features/github/presentation/cubits/repository_details/repository_details_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../../mocks/test_data.dart';

import 'repository_details_cubit_test.mocks.dart';

@GenerateMocks([GetRepositoryDetailsUseCase])
void main() {
  group('RepositoryDetailsCubit', () {
    late RepositoryDetailsCubit cubit;
    late MockGetRepositoryDetailsUseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGetRepositoryDetailsUseCase();
      cubit = RepositoryDetailsCubit(mockUseCase);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be RepositoryDetailsLoading', () {
      expect(cubit.state, const RepositoryDetailsLoading());
    });

    group('loadRepositoryDetails', () {
      const owner = 'flutter';
      const repo = 'flutter';

      final mockDetails = TestData.repositoryDetails;

      blocTest<RepositoryDetailsCubit, RepositoryDetailsState>(
        'emits [RepositoryDetailsLoading, RepositoryDetailsLoaded] when load is successful',
        build: () {
          when(mockUseCase(owner, repo)).thenAnswer((_) async => mockDetails);
          return cubit;
        },
        act: (cubit) => cubit.loadRepositoryDetails(owner: owner, repo: repo),
        expect: () => [
          const RepositoryDetailsLoading(),
          RepositoryDetailsLoaded(mockDetails),
        ],
        verify: (_) {
          verify(mockUseCase(owner, repo)).called(1);
        },
      );

      blocTest<RepositoryDetailsCubit, RepositoryDetailsState>(
        'emits [RepositoryDetailsLoading, RepositoryDetailsError] when load fails',
        build: () {
          when(mockUseCase(owner, repo)).thenThrow(Exception('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.loadRepositoryDetails(owner: owner, repo: repo),
        expect: () => [
          const RepositoryDetailsLoading(),
          const RepositoryDetailsError('Exception: Network error'),
        ],
        verify: (_) {
          verify(mockUseCase(owner, repo)).called(1);
        },
      );

      blocTest<RepositoryDetailsCubit, RepositoryDetailsState>(
        'handles empty issues and pull requests',
        build: () {
          final emptyDetails = TestData.repositoryDetails;
          when(mockUseCase(owner, repo)).thenAnswer((_) async => emptyDetails);
          return cubit;
        },
        act: (cubit) => cubit.loadRepositoryDetails(owner: owner, repo: repo),
        expect: () => [
          const RepositoryDetailsLoading(),
          RepositoryDetailsLoaded(TestData.repositoryDetails),
        ],
        verify: (_) {
          verify(mockUseCase(owner, repo)).called(1);
        },
      );
    });
  });
}
