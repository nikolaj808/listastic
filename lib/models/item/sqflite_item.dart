import 'package:equatable/equatable.dart';

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

  // ignore: sort_constructors_first
  factory SqfliteItem.fromMap(Map<String, dynamic> map) {
    return SqfliteItem(
      id: map['id'] as int,
      shoppinglistId: map['shoppinglistId'] as int,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(map['lastModifiedAt'] as int),
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

  @override
  List<Object> get props => [
        id ?? -1,
        shoppinglistId,
        name,
        quantity,
        createdAt,
        lastModifiedAt,
      ];
}
