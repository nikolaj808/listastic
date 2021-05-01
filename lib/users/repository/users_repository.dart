import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/models/listastic_user.dart';

class UsersRepository {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  Future<ListasticUser> getUserById(String userId) async {
    final userSnapshot = await usersCollection.doc(userId).get();

    final user = ListasticUser.fromSnapshot(userSnapshot);

    return user;
  }

  Future<ListasticUser?> getUserByEmail(String email) async {
    final userQuery =
        await usersCollection.where('email', isEqualTo: email).get();

    if (userQuery.docs.length == 1) {
      final userSnapshot = userQuery.docs.first;

      final user = ListasticUser.fromSnapshot(userSnapshot);

      return user;
    }
  }

  Future<void> createUser(ListasticUser user) async {
    return usersCollection.doc(user.id).set(user.toMap());
  }
}
