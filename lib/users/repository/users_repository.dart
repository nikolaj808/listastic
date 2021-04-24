import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/entities/listastic_user_entity.dart';
import 'package:listastic/models/listastic_user.dart';

class UsersRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<ListasticUser> getUserById(String userId) async {
    final userSnapshot = await usersCollection.doc(userId).get();

    final user = ListasticUser.fromEntity(
        ListasticUserEntity.fromSnapshot(userSnapshot));

    return user;
  }

  Future<void> createUser(ListasticUser user) async {
    return usersCollection.doc(user.id).set(user.toEntity().toMap());
  }
}
