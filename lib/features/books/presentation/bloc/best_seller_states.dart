import 'package:equatable/equatable.dart';
import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';

abstract class BestSellerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BestSellerInitialState extends BestSellerState {}

class BestSellerSuccessState extends BestSellerState {
  final List<BestSellerEntity> bestSellers;
  final List<ListNameEntity> listNames;
  final ListNameEntity listName;

  BestSellerSuccessState(this.bestSellers, this.listNames, this.listName);

  @override
  List<Object> get props => [bestSellers, listNames, listName];
}

class BestSellerErrorState extends BestSellerState {}

class BestSellerLoadingState extends BestSellerState {
  final ListNameEntity? listName;

  BestSellerLoadingState(this.listName);

  @override
  List<Object?> get props => [listName];
}
