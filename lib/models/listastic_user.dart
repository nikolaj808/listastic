import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listastic/entities/listastic_user_entity.dart';

class ListasticUser extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;

  // ignore: sort_constructors_first
  const ListasticUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  ListasticUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return ListasticUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  ListasticUserEntity toEntity() {
    return ListasticUserEntity(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  // ignore: sort_constructors_first
  factory ListasticUser.fromEntity(ListasticUserEntity entity) {
    return ListasticUser(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
    );
  }

  // ignore: sort_constructors_first
  factory ListasticUser.fromUser(User user) {
    return ListasticUser(
      id: user.uid,
      email: user.email!,
      displayName: user.displayName!,
      photoUrl: user.photoURL,
    );
  }

  @override
  List<Object> get props => [id, email, displayName];
}
