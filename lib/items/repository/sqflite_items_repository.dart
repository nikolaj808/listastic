import 'package:listastic/database/database_service.dart';
import 'package:listastic/database/tables/items_table.dart';
import 'package:listastic/models/item/sqflite_item.dart';

class SqfliteItemsRepository {
  final DatabaseService databaseService;

  SqfliteItemsRepository({required this.databaseService});

  Future<List<SqfliteItem>> getItems(int shoppinglistId) async {
    final db = await databaseService.getInstance();

    final data = await db.query(
      ItemsTable().name,
      where: 'shoppinglistId = ?',
      whereArgs: [shoppinglistId],
    );

    final items = data.map((item) => SqfliteItem.fromMap(item)).toList();

    return items;
  }

  Future<SqfliteItem?> getItem(int itemId) async {
    final db = await databaseService.getInstance();

    final data = await db.query(
      ItemsTable().name,
      where: 'itemId = ?',
      whereArgs: [itemId],
    );

    if (data.isNotEmpty) {
      final item = SqfliteItem.fromMap(data.first);

      return item;
    }
  }

  Future<SqfliteItem> createItem(SqfliteItem item) async {
    final db = await databaseService.getInstance();

    final id = await db.insert(
      ItemsTable().name,
      item.toMap(),
    );

    return item.copyWith(id: id);
  }

  Future<SqfliteItem> updateItem(SqfliteItem item) async {
    final db = await databaseService.getInstance();

    await db.update(
      ItemsTable().name,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return item;
  }

  Future<SqfliteItem> deleteItem(SqfliteItem item) async {
    final db = await databaseService.getInstance();

    await db.delete(
      ItemsTable().name,
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return item;
  }
}
