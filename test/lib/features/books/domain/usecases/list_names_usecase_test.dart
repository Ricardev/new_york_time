import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_york_time_api/core/error/error.dart';
import 'package:new_york_time_api/core/usecases/usescase.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';
import 'package:new_york_time_api/features/books/domain/usecases/list_names_usecase.dart';

class MockBookRepository extends Mock implements IBooksRepository {}

void main() {
  late GetListNamesUseCase getListNamesUseCase;
  late IBooksRepository booksRepository;

  setUp(() {
    booksRepository = MockBookRepository();
    getListNamesUseCase = GetListNamesUseCase(booksRepository);
  });

  const tListNameEntity = ListNameEntity("display-name", "encoded-name");

  test("Deve retornar uma lista de best sellers ao retorna do repositorio",
      () async {
    when(() => booksRepository.getListNames())
        .thenAnswer((invocation) async => const Right([tListNameEntity]));

    final result = await getListNamesUseCase(NoParams());
    expect(result, const Right<Error, List<ListNameEntity>>([tListNameEntity]));
    verify(() => booksRepository.getListNames()).called(1);
  });

  test("Deve retornar um erro do usecase", () async {
    when(() => booksRepository.getListNames())
        .thenAnswer((invocation) async => Left(ServerError()));

    final result = await getListNamesUseCase(NoParams());

    expect(result, Left<Error, List<ListNameEntity>>(ServerError()));
    verify(() => booksRepository.getListNames()).called(1);
  });
}
