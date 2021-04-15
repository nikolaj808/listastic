import 'package:equatable/equatable.dart';
import 'package:listastic/entities/shoppinglist_entity/sqflite_shoppinglist_entity.dart';

class SqfliteShoppinglist extends Equatable {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const SqfliteShoppinglist({
    this.id,
    required this.name,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  SqfliteShoppinglist copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return SqfliteShoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  SqfliteShoppinglistEntity toEntity() {
    return SqfliteShoppinglistEntity(
      id: id,
      name: name,
      createdAt: createdAt,
      lastModifiedAt: lastModifiedAt,
    );
  }

  static SqfliteShoppinglist fromEntity(SqfliteShoppinglistEntity entity) {
    return SqfliteShoppinglist(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      lastModifiedAt: entity.lastModifiedAt,
    );
  }

  @override
  List<Object> get props => [
        name,
      ];
}
