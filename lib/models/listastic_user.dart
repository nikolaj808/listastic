import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListasticUser extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  const ListasticUser({
    required this.id,
    this.email,
    this.displayName,
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  factory ListasticUser.fromUser(User user) {
    return ListasticUser(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  factory ListasticUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return ListasticUser(
      id: snapshot.id,
      email: data['email'] as String,
      displayName: data['displayName'] as String,
      photoUrl: data['photoUrl'] as String,
    );
  }

  @override
  List<Object> get props => [id];
}
