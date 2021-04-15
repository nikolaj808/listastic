import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/entities/item_entity/firebase_item_entity.dart';
import 'package:listastic/models/item/firebase_item.dart';

class FirebaseItemsRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('items');

  Stream<List<FirebaseItem>> getItems() {
    return itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
            (doc) =>
                FirebaseItem.fromEntity(FirebaseItemEntity.fromSnapshot(doc)),
          )
          .toList();
    });
  }

  Future<FirebaseItem> getItem(String itemId) async {
    final item = await itemsCollection.doc(itemId).get();

    return FirebaseItem.fromEntity(FirebaseItemEntity.fromSnapshot(item));
  }

  Future<void> createItem(FirebaseItem item) {
    return itemsCollection.add(item.toEntity().toDocument());
  }

  Future<void> updateItem(FirebaseItem item) {
    return itemsCollection.doc(item.id).update(item.toEntity().toDocument());
  }

  Future<void> deleteItem(FirebaseItem item) {
    return itemsCollection.doc(item.id).delete();
  }
}
