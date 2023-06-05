import 'package:new_york_time_api/features/books/domain/entities/list_name_entity.dart';

class ListNameModel extends ListNameEntity {
  const ListNameModel(super.displayName, super.encodedName);

  factory ListNameModel.fromJson(Map<String, dynamic> map) =>
      ListNameModel(map['display_name'], map['list_name_encoded']);

  static List<ListNameModel> listNameModelFromJson(Map<String, dynamic> map) =>
      (map['results'] as List).map((e) => ListNameModel.fromJson(e)).toList();
}
