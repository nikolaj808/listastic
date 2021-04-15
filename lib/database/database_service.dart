import 'package:listastic/database/tables/items_table.dart';
import 'package:listastic/database/tables/shoppinglists_table.dart';
import 'package:listastic/models/shoppinglist/sqflite_shoppinglist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  final _databaseVersion = 1;
  final _databaseName = 'listastic.db';

  Future<Database> getInstance() async {
    final databasePath = await getDatabasesPath();

    return openDatabase(
      join(databasePath, _databaseName),
      singleInstance: true,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createDatabase(db, version);
        await _seedDatabase(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _dropDatabase(db);
        await _createDatabase(db, newVersion);
        await _seedDatabase(db);
      },
    );
  }

  Future<void> _dropDatabase(Database db) async {
    await db.execute('drop table if exists ${ShoppinglistsTable().name}');
    await db.execute('drop table if exists ${ItemsTable().name}');
  }

  Future<void> _createDatabase(Database db, int version) async {
    await ShoppinglistsTable().create(db, version);
    await ItemsTable().create(db, version);
  }

  Future<void> _seedDatabase(Database db) async {
    final now = DateTime.now();

    final personalShoppinglist = SqfliteShoppinglist(
      id: 1,
      name: 'Min indkøbsliste',
      createdAt: now,
      lastModifiedAt: now,
    );

    await db.insert(
      ShoppinglistsTable().name,
      personalShoppinglist.toEntity().toMap(),
    );
  }
}
