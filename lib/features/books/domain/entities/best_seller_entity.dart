import 'package:equatable/equatable.dart';
import 'package:new_york_time_api/features/books/domain/entities/buy_links_entity.dart';

class BestSellerEntity extends Equatable {
  final String primary_isbn10;
  final String primary_isbn13;
  final String publisher;
  final String description;
  final String price;
  final String title;
  final String author;
  final String contributor;
  final String? bookImage;
  final List<BuyLinkEntiy> buyLinks;

  const BestSellerEntity(
      {required this.primary_isbn10,
      required this.primary_isbn13,
      required this.publisher,
      required this.description,
      required this.price,
      required this.title,
      required this.author,
      required this.contributor,
      required this.bookImage,
      this.buyLinks = const []});

  @override
  List<Object?> get props => [
        primary_isbn10,
        primary_isbn13,
        publisher,
        description,
        price,
        title,
        author,
        contributor,
        bookImage,
        buyLinks
      ];
}
