import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShoppinglistEntity extends Equatable {
  final String? id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const ShoppinglistEntity({
    this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  ShoppinglistEntity copyWith({
    String? id,
    String? name,
    String? ownerId,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return ShoppinglistEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id ?? '',
      'name': name,
      'ownerId': ownerId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  static ShoppinglistEntity fromJson(Map<String, Object> json) {
    return ShoppinglistEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastModifiedAt'] as int),
    );
  }

  static ShoppinglistEntity fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return ShoppinglistEntity(
      id: snapshot.id,
      name: data['name'] as String,
      ownerId: data['ownerId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(data['lastModifiedAt'] as int),
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id ?? '',
      'name': name,
      'ownerId': ownerId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object> get props => [
        name,
        ownerId,
      ];
}
