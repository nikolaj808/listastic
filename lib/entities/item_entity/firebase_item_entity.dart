import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseItemEntity extends Equatable {
  final String? id;
  final String name;
  final int quantity;
  final DateTime createdAt;
  final DateTime lastModifiedAt;
  final String userId;
  final String addedByDisplayName;
  final String shoppinglistId;

  // ignore: sort_constructors_first
  const FirebaseItemEntity({
    this.id,
    required this.name,
    required this.quantity,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.userId,
    required this.addedByDisplayName,
    required this.shoppinglistId,
  });

  FirebaseItemEntity copyWith({
    String? id,
    String? name,
    int? quantity,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
    String? userId,
    String? addedByDisplayName,
    String? shoppinglistId,
  }) {
    return FirebaseItemEntity(
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

  Map<String, Object> toJson() {
    return {
      'id': id ?? '',
      'name': name,
      'quantity': quantity,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
      'userId': userId,
      'addedByDisplayName': addedByDisplayName,
      'shoppinglistId': shoppinglistId,
    };
  }

  // ignore: sort_constructors_first
  factory FirebaseItemEntity.fromJson(Map<String, Object> json) {
    return FirebaseItemEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastModifiedAt'] as int),
      userId: json['userId'] as String,
      addedByDisplayName: json['addedByDisplayName'] as String,
      shoppinglistId: json['shoppinglistId'] as String,
    );
  }

  // ignore: sort_constructors_first
  factory FirebaseItemEntity.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return FirebaseItemEntity(
      id: snapshot.id,
      name: data['name'] as String,
      quantity: data['quantity'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(data['lastModifiedAt'] as int),
      userId: data['userId'] as String,
      addedByDisplayName: data['addedByDisplayName'] as String,
      shoppinglistId: data['shoppinglistId'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id ?? '',
      'name': name,
      'quantity': quantity,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
      'userId': userId,
      'addedByDisplayName': addedByDisplayName,
      'shoppinglistId': shoppinglistId,
    };
  }

  @override
  List<Object> get props => [
        name,
        quantity,
      ];
}
