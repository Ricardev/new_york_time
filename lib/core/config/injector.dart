import 'package:get_it/get_it.dart';
import 'package:new_york_time_api/features/books/domain/repository/i_books_repository.dart';
import 'package:new_york_time_api/features/books/domain/usecases/best_sellers_usecase.dart';
import 'package:new_york_time_api/features/books/domain/usecases/list_names_usecase.dart';
import 'package:new_york_time_api/features/books/infra/datasource/book_datasource.dart';
import 'package:new_york_time_api/features/books/infra/datasource/i_book_datasource.dart';
import 'package:new_york_time_api/features/books/infra/repository/books_repository.dart';
import 'package:new_york_time_api/features/books/presentation/bloc/best_seller_bloc.dart';

import '../request/i_request_provider.dart';
import '../request/request_provider.dart';

GetIt injector = GetIt.instance;

Future<void> init() async {
  injector.registerFactory<IRequestProvider>(() => RequestProvider());

  injector.registerFactory<IBookRemoteDatasource>(
      () => BookRemoteDatasource(injector()));
  injector.registerFactory<IBooksRepository>(() => BooksRepository(injector()));
  injector.registerFactory<GetBestSellersUseCase>(
      () => GetBestSellersUseCase(injector()));
  injector.registerFactory<GetListNamesUseCase>(
      () => GetListNamesUseCase(injector()));

  injector.registerFactory<BestSellerBloc>(
      () => BestSellerBloc(injector(), injector()));
}
