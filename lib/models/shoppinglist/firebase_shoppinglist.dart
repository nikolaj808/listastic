import 'package:equatable/equatable.dart';
import 'package:listastic/entities/shoppinglist_entity/firebase_shoppinglist_entity.dart';
import 'package:listastic/models/listastic_user.dart';

class FirebaseShoppinglist extends Equatable {
  final String? id;
  final String name;
  final String ownerId;
  final List<ListasticUser>? users;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const FirebaseShoppinglist({
    this.id,
    required this.name,
    required this.ownerId,
    this.users,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  FirebaseShoppinglist copyWith({
    String? id,
    String? name,
    String? ownerId,
    List<ListasticUser>? users,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return FirebaseShoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      users: users ?? this.users,
      createdAt: createdAt ?? this.createdAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
    );
  }

  FirebaseShoppinglistEntity toEntity() {
    return FirebaseShoppinglistEntity(
      id: id,
      name: name,
      ownerId: ownerId,
      createdAt: createdAt,
      lastModifiedAt: lastModifiedAt,
    );
  }

  static FirebaseShoppinglist fromEntity(FirebaseShoppinglistEntity entity) {
    return FirebaseShoppinglist(
      id: entity.id,
      name: entity.name,
      ownerId: entity.ownerId,
      createdAt: entity.createdAt,
      lastModifiedAt: entity.lastModifiedAt,
    );
  }

  @override
  List<Object> get props => [
        name,
        ownerId,
      ];
}
