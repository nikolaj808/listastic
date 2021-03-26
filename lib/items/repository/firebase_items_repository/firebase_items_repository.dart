import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listastic/entities/item_entity.dart';
import 'package:listastic/items/repository/items_repository.dart';
import 'package:listastic/models/item.dart';

class FirebaseItemsRepository implements ItemsRepository {
  final itemsCollection = FirebaseFirestore.instance.collection('items');

  @override
  Stream<List<Item>> getItems() {
    return itemsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Item.fromEntity(ItemEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<Item> getItem(String itemId) async {
    final newItem = await itemsCollection.doc(itemId).get();

    return Item.fromEntity(ItemEntity.fromSnapshot(newItem));
  }

  @override
  Future<void> createItem(Item item) {
    return itemsCollection.add(item.toEntity().toDocument());
  }

  @override
  Future<void> updateItem(Item item) {
    return itemsCollection.doc(item.id).update(item.toEntity().toDocument());
  }

  @override
  Future<void> deleteItem(Item item) {
    return itemsCollection.doc(item.id).delete();
  }
}
