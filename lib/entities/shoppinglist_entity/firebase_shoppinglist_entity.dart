import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseShoppinglistEntity extends Equatable {
  final String? id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const FirebaseShoppinglistEntity({
    this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  FirebaseShoppinglistEntity copyWith({
    String? id,
    String? name,
    String? ownerId,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return FirebaseShoppinglistEntity(
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

  static FirebaseShoppinglistEntity fromJson(Map<String, Object> json) {
    return FirebaseShoppinglistEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(json['lastModifiedAt'] as int),
    );
  }

  static FirebaseShoppinglistEntity fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return FirebaseShoppinglistEntity(
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
