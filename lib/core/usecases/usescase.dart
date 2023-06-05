import 'package:dartz/dartz.dart';
import 'package:new_york_time_api/core/error/error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Error, Type>> call(Params params);
}

class NoParams {}
