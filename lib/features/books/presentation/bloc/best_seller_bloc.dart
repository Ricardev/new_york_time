import 'package:bloc/bloc.dart';
import 'package:new_york_time_api/core/usecases/usescase.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/domain/usecases/best_sellers_usecase.dart';
import 'package:new_york_time_api/features/books/domain/usecases/list_names_usecase.dart';
import 'package:new_york_time_api/features/books/presentation/bloc/best_seller_states.dart';

class BestSellerBloc extends Cubit<BestSellerState> {
  BestSellerBloc(this._getBestSellersUseCase, this._getListNamesUseCase)
      : super(BestSellerInitialState());

  final GetBestSellersUseCase _getBestSellersUseCase;
  final GetListNamesUseCase _getListNamesUseCase;
  List<ListNameEntity> _listNames = [];

  List<ListNameEntity> listNames() => _listNames;

  Future<void> obterBestSellers(ListNameEntity listName) async {
    final bestSellersResponse =
        await _getBestSellersUseCase(listName.encodedName);

    bestSellersResponse.fold(
        (error) => null,
        (response) =>
            emit(BestSellerSuccessState(response, _listNames, listName)));
  }

  Future<void> obterListNames() async {
    final listNamesResponse = await _getListNamesUseCase(NoParams());

    listNamesResponse.fold((error) => null, (response) async {
      _listNames = response;
      await obterBestSellers(_listNames.first);
    });
  }

  void loading(ListNameEntity? listName) {
    emit(BestSellerLoadingState(listName));
  }
}
