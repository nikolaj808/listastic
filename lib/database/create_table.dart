import 'package:sqflite/sqflite.dart';

Future<void> createTable(
    Database db, int version, String table, List<String> fields) {
  return db.execute("CREATE TABLE IF NOT EXISTS $table(${fields.join(', ')})");
}
