import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';
import 'package:listastic/users/repository/users_repository.dart';

class FirebaseShoppinglistsRepository {
  final UsersRepository _usersRepository = UsersRepository();

  final shoppinglistsCollection =
      FirebaseFirestore.instance.collection('shoppinglists');

  Stream<List<FirebaseShoppinglist>> getShoppinglists() {
    return shoppinglistsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FirebaseShoppinglist.fromSnapshot(doc))
          .toList();
    });
  }

  Future<FirebaseShoppinglist> getShoppinglist(String shoppinglistId) async {
    final shoppinglistSnapshot =
        await shoppinglistsCollection.doc(shoppinglistId).get();

    final shoppinglist =
        FirebaseShoppinglist.fromSnapshot(shoppinglistSnapshot);

    return shoppinglist;
  }

  Future<void> createShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection.add(shoppinglist.toDocument());
  }

  Future<void> updateShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection
        .doc(shoppinglist.id)
        .update(shoppinglist.toDocument());
  }

  Future<void> deleteShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection.doc(shoppinglist.id).delete();
  }

  Future<void> addUserToShoppinglist(
      FirebaseShoppinglist shoppinglist, String email) async {
    final userBeingAdded = await _usersRepository.getUserByEmail(email);

    if (userBeingAdded == null) {
      throw Exception('User does not exist');
    }

    if (shoppinglist.ownerId == userBeingAdded.id) {
      throw Exception('User is already the owner of the group');
    }

    final usersInGroup = shoppinglist.userIds;

    if (usersInGroup.any((userId) => userId == userBeingAdded.id)) {
      throw Exception('User is already in group');
    }

    return shoppinglistsCollection
        .doc(shoppinglist.id)
        .collection('sharedWith')
        .doc(userBeingAdded.id)
        .set(userBeingAdded.toMap());
  }
}
