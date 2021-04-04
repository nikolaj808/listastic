import 'package:equatable/equatable.dart';
import 'package:listastic/entities/group_user_entity.dart';

class GroupUser extends Equatable {
  final String? id;
  final String userId;

  // ignore: sort_constructors_first
  const GroupUser({
    this.id,
    required this.userId,
  });

  GroupUser copyWith({
    String? id,
    String? userId,
  }) {
    return GroupUser(
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  GroupUserEntity toEntity() {
    return GroupUserEntity(
      id: id,
      userId: userId,
    );
  }

  static GroupUser fromEntity(GroupUserEntity entity) {
    return GroupUser(
      id: entity.id,
      userId: entity.userId,
    );
  }

  @override
  List<Object> get props => [userId];
}
