import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/entities/group_user_entity.dart';
import 'package:listastic/entities/shoppinglist_entity.dart';
import 'package:listastic/models/group_user.dart';
import 'package:listastic/models/shoppinglist.dart';
import 'package:listastic/shoppinglists/repository/shoppinglists_repository.dart';

class FirebaseShoppinglistsRepository implements ShoppinglistsRepository {
  final shoppinglistsCollection =
      FirebaseFirestore.instance.collection('shoppinglists');

  @override
  Stream<List<Shoppinglist>> getShoppinglists() {
    return shoppinglistsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) => Shoppinglist.fromEntity(
              ShoppinglistEntity.fromSnapshot(doc),
            ),
          )
          .toList();
    });
  }

  @override
  Future<Shoppinglist> getShoppinglist(String shoppinglistId) async {
    final shoppinglistSnapshot =
        await shoppinglistsCollection.doc(shoppinglistId).get();

    final groupUsersSnapshot = await shoppinglistsCollection
        .doc(shoppinglistId)
        .collection('sharedWith')
        .get();

    final shoppinglist = Shoppinglist.fromEntity(
        ShoppinglistEntity.fromSnapshot(shoppinglistSnapshot));

    final groupUsers = groupUsersSnapshot.docs.map((snapshot) {
      return GroupUser.fromEntity(GroupUserEntity.fromSnapshot(snapshot));
    }).toList();

    final shoppinglistWithUsers = shoppinglist.copyWith(groupUsers: groupUsers);

    return shoppinglistWithUsers;
  }

  @override
  Future<void> createShoppinglist(Shoppinglist shoppinglist) {
    return shoppinglistsCollection.add(shoppinglist.toEntity().toDocument());
  }

  @override
  Future<void> updateShoppinglist(Shoppinglist shoppinglist) {
    return shoppinglistsCollection
        .doc(shoppinglist.id)
        .update(shoppinglist.toEntity().toDocument());
  }

  @override
  Future<void> deleteShoppinglist(Shoppinglist shoppinglist) {
    return shoppinglistsCollection.doc(shoppinglist.id).delete();
  }
}
