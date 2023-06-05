import 'package:new_york_time_api/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:new_york_time_api/core/usecases/usescase.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';

class GetBestSellersUseCase extends UseCase<List<BestSellerEntity>, String> {
  final IBooksRepository _booksRepository;

  GetBestSellersUseCase(this._booksRepository);

  @override
  Future<Either<Error, List<BestSellerEntity>>> call(String params) async {
    return _booksRepository.getBestSellers(params);
  }
}
