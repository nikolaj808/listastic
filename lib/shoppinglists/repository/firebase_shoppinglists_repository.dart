import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/entities/listastic_user_entity.dart';
import 'package:listastic/entities/shoppinglist_entity/firebase_shoppinglist_entity.dart';
import 'package:listastic/models/listastic_user.dart';
import 'package:listastic/models/shoppinglist/firebase_shoppinglist.dart';

class FirebaseShoppinglistsRepository {
  final shoppinglistsCollection =
      FirebaseFirestore.instance.collection('shoppinglists');

  Stream<List<FirebaseShoppinglist>> getShoppinglists() {
    return shoppinglistsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => FirebaseShoppinglist.fromEntity(
              FirebaseShoppinglistEntity.fromSnapshot(doc),
            ),
          )
          .toList();
    });
  }

  Future<FirebaseShoppinglist> getShoppinglist(String shoppinglistId) async {
    final shoppinglistSnapshot =
        await shoppinglistsCollection.doc(shoppinglistId).get();

    final groupUsersSnapshot = await shoppinglistsCollection
        .doc(shoppinglistId)
        .collection('sharedWith')
        .get();

    final shoppinglist = FirebaseShoppinglist.fromEntity(
        FirebaseShoppinglistEntity.fromSnapshot(shoppinglistSnapshot));

    final shoppinglistUsers = groupUsersSnapshot.docs.map((snapshot) {
      return ListasticUser.fromEntity(
          ListasticUserEntity.fromMap(snapshot.data() ?? {}));
    }).toList();

    final shoppinglistWithUsers =
        shoppinglist.copyWith(users: shoppinglistUsers);

    return shoppinglistWithUsers;
  }

  Future<void> createShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection.add(shoppinglist.toEntity().toDocument());
  }

  Future<void> updateShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection
        .doc(shoppinglist.id)
        .update(shoppinglist.toEntity().toDocument());
  }

  Future<void> deleteShoppinglist(FirebaseShoppinglist shoppinglist) {
    return shoppinglistsCollection.doc(shoppinglist.id).delete();
  }
}
