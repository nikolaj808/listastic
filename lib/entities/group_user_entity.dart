import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class GroupUserEntity extends Equatable {
  final String? id;
  final String userId;

  // ignore: sort_constructors_first
  const GroupUserEntity({
    this.id,
    required this.userId,
  });

  GroupUserEntity copyWith({
    String? id,
    String? userId,
  }) {
    return GroupUserEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
    );
  }

  Map<String, Object> toJson() {
    return {
      'id': id ?? '',
      'userId': userId,
    };
  }

  static GroupUserEntity fromJson(Map<String, Object> json) {
    return GroupUserEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
    );
  }

  static GroupUserEntity fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return GroupUserEntity(
      id: snapshot.id,
      userId: data['userId'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id ?? '',
      'userId': userId,
    };
  }

  @override
  List<Object> get props => [userId];
}
