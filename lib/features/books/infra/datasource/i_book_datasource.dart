import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';

abstract class IBookRemoteDatasource {
  Future<List<BestSellerEntity>> getBestSellersRemotelyAsync(String params);

  Future<List<ListNameEntity>> getListNamesRemotelyAsync();
}
