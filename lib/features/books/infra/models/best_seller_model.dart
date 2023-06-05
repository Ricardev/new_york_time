import 'package:new_york_time_api/features/books/domain/entities/best_seller_entity.dart';
import 'package:new_york_time_api/features/books/infra/models/buy_links_model.dart';

class BestSellerModel extends BestSellerEntity {
  const BestSellerModel(
      {required super.primary_isbn10,
      required super.primary_isbn13,
      required super.publisher,
      required super.description,
      required super.price,
      required super.title,
      required super.author,
      required super.contributor,
      required super.bookImage,
      super.buyLinks});

  factory BestSellerModel.fromJson(Map<String, dynamic> map) => BestSellerModel(
      primary_isbn10: map['primary_isbn10'],
      primary_isbn13: map['primary_isbn13'],
      publisher: map['publisher'],
      description: map['description'],
      price: map['price'],
      title: map['title'],
      author: map['author'],
      contributor: map['contributor'],
      bookImage: map['book_image'],
      buyLinks: (map['buy_links'] as List)
          .map((e) => BuyLinkModel.fromjson(e))
          .toList());

  static List<BestSellerModel> bestSellerModelListFromJson(
          Map<String, dynamic> map) =>
      (map['results']['books'] as List)
          .map((e) => BestSellerModel.fromJson(e))
          .toList();
}
