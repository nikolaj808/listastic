import 'package:equatable/equatable.dart';
import 'package:listastic/entities/item_entity/firebase_item_entity.dart';

class FirebaseItem extends Equatable {
  final String? id;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;
  final String userId;
  final String addedByDisplayName;
  final String shoppinglistId;

  // ignore: sort_constructors_first
  const FirebaseItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.addedByDisplayName,
    required this.shoppinglistId,
  });

  FirebaseItem copyWith({
    String? id,
    String? name,
    int? quantity,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? userId,
    String? addedByDisplayName,
    String? shoppinglistId,
  }) {
    return FirebaseItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      userId: userId ?? this.userId,
      addedByDisplayName: addedByDisplayName ?? this.addedByDisplayName,
      shoppinglistId: shoppinglistId ?? this.shoppinglistId,
    );
  }

  FirebaseItemEntity toEntity() {
    return FirebaseItemEntity(
      id: id,
      name: name,
      quantity: quantity,
      createdAt: createdAt,
      lastModifiedAt: lastModifiedAt,
      userId: userId,
      addedByDisplayName: addedByDisplayName,
      shoppinglistId: shoppinglistId,
    );
  }

  static FirebaseItem fromEntity(FirebaseItemEntity entity) {
    return FirebaseItem(
      id: entity.id,
      name: entity.name,
      quantity: entity.quantity,
      createdAt: entity.createdAt,
      lastModifiedAt: entity.lastModifiedAt,
      userId: entity.userId,
      addedByDisplayName: entity.addedByDisplayName,
      shoppinglistId: entity.shoppinglistId,
    );
  }

  @override
  List<Object> get props => [
        name,
        quantity,
      ];
}
