import 'package:sqflite/sqflite.dart';

abstract class DatabaseTable {
  String get name;

  Future<void> create(Database db, int version);
}
