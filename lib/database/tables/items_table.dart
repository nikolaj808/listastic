import 'package:listastic/database/create_table.dart';
import 'package:listastic/database/database_table.dart';
import 'package:listastic/database/tables/shoppinglists_table.dart';
import 'package:sqflite/sqflite.dart';

class ItemsTable extends DatabaseTable {
  @override
  Future<void> create(Database db, int version) async {
    await createTable(db, version, name, [
      'id INTEGER PRIMARY KEY',
      'name TEXT',
      'quantity INTEGER',
      'createdAt INTEGER',
      'lastModifiedAt INTEGER',
      'shoppinglistId INTEGER',
      'FOREIGN KEY(shoppinglistId) REFERENCES ${ShoppinglistsTable().name}(id)',
    ]);
  }

  @override
  String get name => 'items';
}
