import 'package:new_york_time_api/features/books/domain/entities/buy_links_entity.dart';

class BuyLinkModel extends BuyLinkEntiy {
  const BuyLinkModel(super.name, super.url);

  factory BuyLinkModel.fromjson(Map<String, dynamic> map) =>
      BuyLinkModel(map['name'], map['url']);
}
