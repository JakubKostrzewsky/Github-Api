import 'package:flutter_test/flutter_test.dart';
import 'package:github/features/github/domain/repositories/repositories_repository.dart';
import 'package:github/features/github/domain/usecases/get_repositories_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../mocks/test_data.dart';

import 'get_repositories_usecase_test.mocks.dart';

@GenerateMocks([RepositoriesRepository])
void main() {
  group('GetRepositoriesUseCase', () {
    late GetRepositoriesUseCase useCase;
    late MockRepositoriesRepository mockRepository;

    setUp(() {
      mockRepository = MockRepositoriesRepository();
      useCase = GetRepositoriesUseCase(mockRepository);
    });

    test(
        'should return list of repositories when repository call is successful',
        () async {
      // Arrange
      const query = 'flutter';
      final expectedRepositories = TestData.repositories;

      when(mockRepository.searchRepositories(query))
          .thenAnswer((_) async => expectedRepositories);

      // Act
      final result = await useCase(query);

      // Assert
      expect(result, expectedRepositories);
      verify(mockRepository.searchRepositories(query)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should throw exception when repository throws exception', () async {
      // Arrange
      const query = 'flutter';
      const errorMessage = 'Network error';

      when(mockRepository.searchRepositories(query))
          .thenThrow(Exception(errorMessage));

      // Act & Assert
      expect(
        () => useCase(query),
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.searchRepositories(query)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
