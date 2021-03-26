import 'package:listastic/models/item.dart';

abstract class ItemsRepository {
  Stream<List<Item>> getItems();

  Future<Item> getItem(String itemId);

  Future<void> createItem(Item item);

  Future<void> updateItem(Item item);

  Future<void> deleteItem(Item item);
}
