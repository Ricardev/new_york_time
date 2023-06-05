import 'package:equatable/equatable.dart';

class ListNameEntity extends Equatable {
  final String displayName;
  final String encodedName;

  const ListNameEntity(this.displayName, this.encodedName);

  @override
  List<Object?> get props => [displayName, encodedName];
}
