import 'package:equatable/equatable.dart';

class BuyLinkEntiy extends Equatable {
  final String name;
  final String url;

  const BuyLinkEntiy(this.name, this.url);

  @override
  List<Object?> get props => [name, url];
}
