import 'package:equatable/equatable.dart';
import 'package:listastic/entities/item_entity/sqflite_item_entity.dart';

class SqfliteItem extends Equatable {
  final int? id;
  final int shoppinglistId;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const SqfliteItem({
    this.id,
    required this.shoppinglistId,
    required this.name,
    required this.quantity,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  SqfliteItem copyWith({
    int? id,
    int? shoppinglistId,
    String? name,
    int? quantity,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return SqfliteItem(
      id: id ?? this.id,
      shoppinglistId: shoppinglistId ?? this.shoppinglistId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  SqfliteItemEntity toEntity() {
    return SqfliteItemEntity(
      id: id,
      shoppinglistId: shoppinglistId,
      name: name,
      quantity: quantity,
      createdAt: createdAt,
      lastModifiedAt: lastModifiedAt,
    );
  }

  static SqfliteItem fromEntity(SqfliteItemEntity entity) {
    return SqfliteItem(
      id: entity.id,
      shoppinglistId: entity.shoppinglistId,
      name: entity.name,
      quantity: entity.quantity,
      createdAt: entity.createdAt,
      lastModifiedAt: entity.lastModifiedAt,
    );
  }

  @override
  List<Object> get props => [
        name,
        quantity,
      ];
}
