import 'package:new_york_time_api/core/error/exceptions.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';
import 'package:new_york_time_api/features/books/infra/datasource/i_book_datasource.dart';

class BooksRepository implements IBooksRepository {
  final IBookRemoteDatasource _bookRemoteDatasource;

  BooksRepository(this._bookRemoteDatasource);

  @override
  Future<Either<Error, List<BestSellerEntity>>> getBestSellers(
      String param) async {
    try {
      final bestSellers =
          await _bookRemoteDatasource.getBestSellersRemotelyAsync(param);
      return Right(bestSellers);
    } on ServerException {
      return Left(ServerError());
    }
  }

  @override
  Future<Either<Error, List<ListNameEntity>>> getListNames() async {
    try {
      final listNames = await _bookRemoteDatasource.getListNamesRemotelyAsync();
      return Right(listNames);
    } on ServerException {
      return Left(ServerError());
    }
  }
}
