import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseShoppinglist extends Equatable {
  final String? id;
  final String name;
  final String ownerId;
  final List<String> userIds;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const FirebaseShoppinglist({
    this.id,
    required this.name,
    required this.ownerId,
    required this.userIds,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  FirebaseShoppinglist copyWith({
    String? id,
    String? name,
    String? ownerId,
    List<String>? userIds,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return FirebaseShoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      userIds: userIds ?? this.userIds,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  // ignore: sort_constructors_first
  factory FirebaseShoppinglist.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return FirebaseShoppinglist(
      id: snapshot.id,
      name: data['name'] as String,
      ownerId: data['ownerId'] as String,
      userIds: data['userIds'] as List<String>,
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt'] as int),
      lastModifiedAt:
          DateTime.fromMillisecondsSinceEpoch(data['lastModifiedAt'] as int),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'userIds': userIds,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastModifiedAt': lastModifiedAt.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object> get props => [
        id ?? '',
        name,
        ownerId,
        createdAt,
        lastModifiedAt,
      ];
}
