import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseItem extends Equatable {
  final String? id;
  final String shoppinglistId;
  final String userId;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  const FirebaseItem({
    this.id,
    required this.shoppinglistId,
    required this.userId,
    required this.name,
    required this.quantity,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  FirebaseItem copyWith({
    String? id,
    String? shoppinglistId,
    String? userId,
    String? name,
    int? quantity,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return FirebaseItem(
      id: id ?? this.id,
      shoppinglistId: shoppinglistId ?? this.shoppinglistId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  factory FirebaseItem.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return FirebaseItem(
      id: snapshot.id,
      shoppinglistId: data['shoppinglistId'] as String,
      userId: data['userId'] as String,
      name: data['name'] as String,
      quantity: data['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(data['lastModifiedAt'] as int),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'shoppinglistId': shoppinglistId,
      'userId': userId,
      'name': name,
      'quantity': quantity,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object> get props => [
        id ?? '',
        shoppinglistId,
        userId,
        name,
        quantity,
        createdAt,
        lastModifiedAt,
      ];
}
