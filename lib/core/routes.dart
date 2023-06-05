import 'package:flutter/cupertino.dart';
import 'package:new_york_time_api/features/books/presentation/pages/best_seller_pages.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    "books": (context) => const BestSellerPage()
  };
}
