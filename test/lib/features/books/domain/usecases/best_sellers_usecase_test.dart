import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_york_time_api/core/error/error.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';
import 'package:new_york_time_api/features/books/domain/usecases/best_sellers_usecase.dart';

class MockBookRepository extends Mock implements IBooksRepository {}

void main() {
  late GetBestSellersUseCase getBestSellersUseCase;
  late IBooksRepository booksRepository;

  setUp(() {
    booksRepository = MockBookRepository();
    getBestSellersUseCase = GetBestSellersUseCase(booksRepository);
  });

  const tBestSellerEntity = BestSellerEntity(
      primary_isbn10: "1",
      primary_isbn13: "1",
      publisher: "publisher",
      description: "description",
      price: "price",
      title: "title",
      author: "author",
      contributor: "contributor",
      bookImage: "bookImage",
      buyLinks: []);

  test("Deve retornar uma lista de best sellers ao retorna do repositorio",
      () async {
    when(() => booksRepository.getBestSellers(any()))
        .thenAnswer((invocation) async => const Right([tBestSellerEntity]));

    final result = await getBestSellersUseCase("encoded-name");
    expect(result,
        const Right<Error, List<BestSellerEntity>>([tBestSellerEntity]));
    verify(() => booksRepository.getBestSellers("encoded-name")).called(1);
  });

  test("Deve retornar um erro do usecase", () async {
    when(() => booksRepository.getBestSellers(any()))
        .thenAnswer((invocation) async => Left(ServerError()));

    final result = await getBestSellersUseCase('encoded-name');

    expect(result, Left<Error, List<BestSellerEntity>>(ServerError()));
    verify(() => booksRepository.getBestSellers('encoded-name')).called(1);
  });
}
