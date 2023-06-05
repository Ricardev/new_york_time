import 'package:new_york_time_api/core/request/i_request_provider.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/infra/datasource/i_book_datasource.dart';
import 'package:new_york_time_api/features/books/infra/models/best_seller_model.dart';
import 'package:new_york_time_api/features/books/infra/models/list_name_model.dart';

class BookRemoteDatasource implements IBookRemoteDatasource {
  final IRequestProvider _requestProvider;
  final String urlBase = "https://api.nytimes.com/svc/books/v3/";
  BookRemoteDatasource(this._requestProvider);

  @override
  Future<List<BestSellerEntity>> getBestSellersRemotelyAsync(
      String params) async {
    final response =
        await _requestProvider.getAsync("${urlBase}lists/current/$params.json");
    final bestSellers = BestSellerModel.bestSellerModelListFromJson(response);
    return bestSellers;
  }

  @override
  Future<List<ListNameEntity>> getListNamesRemotelyAsync() async {
    final response =
        await _requestProvider.getAsync("${urlBase}lists/names.json");
    final listNames = ListNameModel.listNameModelFromJson(response);
    return listNames;
  }
}
