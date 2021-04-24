import 'package:listastic/database/database_service.dart';
import 'package:listastic/database/tables/items_table.dart';
import 'package:listastic/entities/item_entity/sqflite_item_entity.dart';
import 'package:listastic/models/item/sqflite_item.dart';

class SqfliteItemsRepository {
  final DatabaseService databaseService;

  // ignore: sort_constructors_first
  SqfliteItemsRepository({required this.databaseService});

  // TODO: Only get items from shoppinglist with ID
  Future<List<SqfliteItem>> getItems(int shoppinglistId) async {
    final db = await databaseService.getInstance();

    final data = await db.query(
      ItemsTable().name,
      where: 'shoppinglistId = ?',
      whereArgs: [shoppinglistId],
    );

    final items = data
        .map(
          (item) => SqfliteItem.fromEntity(
            SqfliteItemEntity.fromMap(item),
          ),
        )
        .toList();

    return items;
  }

  Future<SqfliteItem> getItem(int itemId) async {
    // TODO: Implement getItem
    throw UnimplementedError();
  }

  Future<SqfliteItem> createItem(SqfliteItem item) async {
    final db = await databaseService.getInstance();

    final id = await db.insert(
      ItemsTable().name,
      item.toEntity().toMap(),
    );

    return item.copyWith(id: id);
  }

  Future<SqfliteItem> updateItem(SqfliteItem item) async {
    // TODO: Implement updateItem
    throw UnimplementedError();
  }

  Future<SqfliteItem> deleteItem(SqfliteItem item) async {
    // TODO: Implement deleteItem
    throw UnimplementedError();
  }

  // Future<List<SqfliteShoppinglist>> getShoppinglists() async {
  //   final db = await databaseService.getInstance();

  //   final data = await db.query(
  //     ShoppinglistsTable().name,
  //   );

  //   final shoppinglists = data
  //       .map(
  //         (shoppinglist) => SqfliteShoppinglist.fromEntity(
  //           SqfliteShoppinglistEntity.fromMap(shoppinglist),
  //         ),
  //       )
  //       .toList();

  //   return shoppinglists;
  // }

  // Future<SqfliteShoppinglist?> getShoppinglist(String shoppinglistId) async {
  //   final db = await databaseService.getInstance();

  //   final data = await db.query(
  //     ShoppinglistsTable().name,
  //     where: 'id = ?',
  //     whereArgs: [shoppinglistId],
  //   );

  //   final shoppinglists = data
  //       .map(
  //         (shoppinglist) => SqfliteShoppinglist.fromEntity(
  //           SqfliteShoppinglistEntity.fromMap(shoppinglist),
  //         ),
  //       )
  //       .toList();

  //   if (shoppinglists.isNotEmpty) {
  //     final shoppinglist = shoppinglists.first;

  //     return shoppinglist;
  //   }

  //   return null;
  // }

  // Future<SqfliteShoppinglist> createShoppinglist(
  //     SqfliteShoppinglist shoppinglist) async {
  //   final db = await databaseService.getInstance();

  //   final shoppinglistId = await db.insert(
  //     ShoppinglistsTable().name,
  //     shoppinglist.toEntity().toMap(),
  //   );

  //   final createdShoppinglist = shoppinglist.copyWith(id: shoppinglistId);

  //   return createdShoppinglist;
  // }

  // Future<SqfliteShoppinglist> updateShoppinglist(
  //     SqfliteShoppinglist shoppinglist) async {
  //   final db = await databaseService.getInstance();

  //   await db.update(
  //     ShoppinglistsTable().name,
  //     shoppinglist.toEntity().toMap(),
  //     where: 'id = ?',
  //     whereArgs: [shoppinglist.id],
  //   );

  //   return shoppinglist;
  // }

  // Future<SqfliteShoppinglist> deleteShoppinglist(
  //     SqfliteShoppinglist shoppinglist) async {
  //   final db = await databaseService.getInstance();

  //   await db.delete(
  //     ShoppinglistsTable().name,
  //     where: 'id = ?',
  //     whereArgs: [shoppinglist.id],
  //   );

  //   return shoppinglist;
  // }
}
