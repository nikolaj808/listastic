import 'package:equatable/equatable.dart';
import 'package:listastic/entities/shoppinglist_entity/firebase_shoppinglist_entity.dart';
import 'package:listastic/models/group_user.dart';

class FirebaseShoppinglist extends Equatable {
  final String? id;
  final String name;
  final String ownerId;
  final List<GroupUser>? groupUsers;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  // ignore: sort_constructors_first
  const FirebaseShoppinglist({
    this.id,
    required this.name,
    required this.ownerId,
    this.groupUsers,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  FirebaseShoppinglist copyWith({
    String? id,
    String? name,
    String? ownerId,
    List<GroupUser>? groupUsers,
    DateTime? createdAt,
    DateTime? lastModifiedAt,
  }) {
    return FirebaseShoppinglist(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      groupUsers: groupUsers ?? this.groupUsers,
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
