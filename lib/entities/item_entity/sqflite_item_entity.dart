import 'package:equatable/equatable.dart';

class SqfliteItemEntity extends Equatable {
  final int? id;
  final int shoppinglistId;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const SqfliteItemEntity({
    this.id,
    required this.shoppinglistId,
    required this.name,
    required this.quantity,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  SqfliteItemEntity copyWith({
    int? id,
    int? shoppinglistId,
    String? name,
    int? quantity,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return SqfliteItemEntity(
      id: id ?? this.id,
      shoppinglistId: shoppinglistId ?? this.shoppinglistId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shoppinglistId': shoppinglistId,
      'name': name,
      'quantity': quantity,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory SqfliteItemEntity.fromMap(Map<String, dynamic> json) {
    return SqfliteItemEntity(
      id: json['id'] as int,
      shoppinglistId: json['shoppinglistId'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastModifiedAt'] as int),
    );
  }

  @override
  List<Object> get props => [
        name,
        quantity,
      ];
}
