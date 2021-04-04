import 'package:listastic/models/shoppinglist.dart';

abstract class ShoppinglistsRepository {
  Stream<List<Shoppinglist>> getShoppinglists();

  Future<Shoppinglist> getShoppinglist(String shoppinglistId);

  Future<void> createShoppinglist(Shoppinglist item);

  Future<void> updateShoppinglist(Shoppinglist item);

  Future<void> deleteShoppinglist(Shoppinglist item);
}
