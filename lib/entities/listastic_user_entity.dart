import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ListasticUserEntity extends Equatable {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;

  // ignore: sort_constructors_first
  const ListasticUserEntity({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  ListasticUserEntity copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) {
    return ListasticUserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  // ignore: sort_constructors_first
  factory ListasticUserEntity.fromMap(Map<String, dynamic> json) {
    return ListasticUserEntity(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }

  // ignore: sort_constructors_first
  factory ListasticUserEntity.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()!;

    return ListasticUserEntity(
      id: snapshot.id,
      email: data['email'] as String,
      displayName: data['displayName'] as String,
      photoUrl: data['photoUrl'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl ?? '',
    };
  }

  @override
  List<Object> get props => [id, email, displayName];
}
