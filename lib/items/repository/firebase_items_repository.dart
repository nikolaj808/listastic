import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/models/item/firebase_item.dart';

class FirebaseItemsRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('items');

  Stream<List<FirebaseItem>> getItems(String shoppinglistId) {
    return itemsCollection
        .where('shoppinglistId', isEqualTo: shoppinglistId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FirebaseItem.fromSnapshot(doc))
              .toList(),
        );
  }

  Future<FirebaseItem> getItem(String itemId) async {
    final item = await itemsCollection.doc(itemId).get();

    return FirebaseItem.fromSnapshot(item);
  }

  Future<void> createItem(FirebaseItem item) {
    return itemsCollection.add(item.toDocument());
  }

  Future<void> updateItem(FirebaseItem item) {
    return itemsCollection.doc(item.id).update(item.toDocument());
  }

  Future<void> deleteItem(FirebaseItem item) {
    return itemsCollection.doc(item.id).delete();
  }
}
