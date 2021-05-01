import 'package:listastic/database/database_service.dart';
import 'package:listastic/database/tables/shoppinglists_table.dart';
import 'package:listastic/models/shoppinglist/sqflite_shoppinglist.dart';

class SqfliteShoppinglistsRepository {
  final DatabaseService databaseService;

  // ignore: sort_constructors_first
  SqfliteShoppinglistsRepository({required this.databaseService});

  Future<List<SqfliteShoppinglist>> getShoppinglists() async {
    final db = await databaseService.getInstance();

    final data = await db.query(
      ShoppinglistsTable().name,
    );

    final shoppinglists = data
        .map((shoppinglist) => SqfliteShoppinglist.fromMap(shoppinglist))
        .toList();

    return shoppinglists;
  }

  Future<SqfliteShoppinglist?> getShoppinglist(String shoppinglistId) async {
    final db = await databaseService.getInstance();

    final data = await db.query(
      ShoppinglistsTable().name,
      where: 'id = ?',
      whereArgs: [shoppinglistId],
    );

    final shoppinglists = data
        .map((shoppinglist) => SqfliteShoppinglist.fromMap(shoppinglist))
        .toList();

    if (shoppinglists.isNotEmpty) {
      final shoppinglist = shoppinglists.first;

      return shoppinglist;
    }
  }

  Future<SqfliteShoppinglist> createShoppinglist(
      SqfliteShoppinglist shoppinglist) async {
    final db = await databaseService.getInstance();

    final shoppinglistId = await db.insert(
      ShoppinglistsTable().name,
      shoppinglist.toMap(),
    );

    final createdShoppinglist = shoppinglist.copyWith(id: shoppinglistId);

    return createdShoppinglist;
  }

  Future<SqfliteShoppinglist> updateShoppinglist(
      SqfliteShoppinglist shoppinglist) async {
    final db = await databaseService.getInstance();

    await db.update(
      ShoppinglistsTable().name,
      shoppinglist.toMap(),
      where: 'id = ?',
      whereArgs: [shoppinglist.id],
    );

    return shoppinglist;
  }

  Future<SqfliteShoppinglist> deleteShoppinglist(
      SqfliteShoppinglist shoppinglist) async {
    final db = await databaseService.getInstance();

    await db.delete(
      ShoppinglistsTable().name,
      where: 'id = ?',
      whereArgs: [shoppinglist.id],
    );

    return shoppinglist;
  }
}
