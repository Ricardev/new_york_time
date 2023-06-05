import 'package:new_york_time_api/core/error/error.dart';
import 'package:dartz/dartz.dart';
import 'package:new_york_time_api/core/usecases/usescase.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';

class GetListNamesUseCase extends UseCase<List<ListNameEntity>, NoParams> {
  final IBooksRepository _booksRepository;

  GetListNamesUseCase(this._booksRepository);
  @override
  Future<Either<Error, List<ListNameEntity>>> call(NoParams params) async {
    return _booksRepository.getListNames();
  }
}
