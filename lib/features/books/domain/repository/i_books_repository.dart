import 'package:dartz/dartz.dart';
import 'package:new_york_time_api/core/error/error.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';

abstract class IBooksRepository {
  Future<Either<Error, List<BestSellerEntity>>> getBestSellers(String param);

  Future<Either<Error, List<ListNameEntity>>> getListNames();
}
