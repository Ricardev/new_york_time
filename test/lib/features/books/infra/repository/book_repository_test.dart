import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_york_time_api/core/error/error.dart';
import 'package:new_york_time_api/core/error/exceptions.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/infra/datasource/i_book_datasource.dart';
import 'package:new_york_time_api/features/books/infra/models/best_seller_model.dart';
import 'package:new_york_time_api/features/books/infra/models/list_name_model.dart';
import 'package:new_york_time_api/features/books/infra/repository/books_repository.dart';

class MockBookRemoteDatasource extends Mock implements IBookRemoteDatasource {}

void main() {
  late IBookRemoteDatasource bookRemoteDatasource;
  late BooksRepository booksRepository;
  setUp(() {
    bookRemoteDatasource = MockBookRemoteDatasource();
    booksRepository = BooksRepository(bookRemoteDatasource);
  });

  group("Teste de repositorio referentes aos best sellers", () {
    const tBestSellerListModel = [
      BestSellerModel(
          primary_isbn10: "1",
          primary_isbn13: "1",
          publisher: "publisher",
          description: "description",
          price: "price",
          title: "title",
          author: "author",
          contributor: "contributor",
          bookImage: "bookImage")
    ];
    test("Retorna uma lista de best sellers", () async {
      when(() => bookRemoteDatasource.getBestSellersRemotelyAsync(any()))
          .thenAnswer((invocation) async => tBestSellerListModel);

      final result = await booksRepository.getBestSellers('encoded-name');
      expect(result,
          const Right<Error, List<BestSellerModel>>(tBestSellerListModel));
      expect(result, isA<Right<Error, List<BestSellerEntity>>>());
      verify(() =>
              bookRemoteDatasource.getBestSellersRemotelyAsync('encoded-name'))
          .called(1);
    });

    test("Retorna erro ao chamar o data source", () async {
      when(() => bookRemoteDatasource.getBestSellersRemotelyAsync(any()))
          .thenAnswer((invocation) async => throw ServerException());

      final result = await booksRepository.getBestSellers('encoded-name');

      expect(result, Left<Error, List<BestSellerModel>>(ServerError()));
      expect(result, isA<Left<Error, List<BestSellerEntity>>>());
      verify(() =>
              bookRemoteDatasource.getBestSellersRemotelyAsync('encoded-name'))
          .called(1);
    });
  });

  group("Teste referentes à lista de nomes que permite filtrar os best sellers",
      () {
    const tListNamesList = [ListNameModel("displayName", "encodedName")];
    test("Retorna uma lista de list names", () async {
      when(() => bookRemoteDatasource.getListNamesRemotelyAsync())
          .thenAnswer((invocation) async => tListNamesList);

      final result = await booksRepository.getListNames();
      expect(result, const Right<Error, List<ListNameModel>>(tListNamesList));
      expect(result, isA<Right<Error, List<ListNameEntity>>>());
      verify(() => bookRemoteDatasource.getListNamesRemotelyAsync()).called(1);
    });

    test("Retorna erro ao chamar o data source", () async {
      when(() => bookRemoteDatasource.getListNamesRemotelyAsync())
          .thenAnswer((invocation) async => throw ServerException());

      final result = await booksRepository.getListNames();

      expect(result, Left<Error, List<ListNameModel>>(ServerError()));
      expect(result, isA<Left<Error, List<ListNameEntity>>>());
      verify(() => bookRemoteDatasource.getListNamesRemotelyAsync()).called(1);
    });
  });
}
