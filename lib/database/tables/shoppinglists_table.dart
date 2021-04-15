import 'package:listastic/database/create_table.dart';
import 'package:listastic/database/database_table.dart';
import 'package:sqflite/sqflite.dart';

class ShoppinglistsTable extends DatabaseTable {
  @override
  Future<void> create(Database db, int version) async {
    await createTable(db, version, name, [
      'id INTEGER PRIMARY KEY',
      'name TEXT',
      'createdAt INTEGER',
      'lastModifiedAt INTEGER',
    ]);
  }

  @override
  String get name => 'shoppinglists';
}
