import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  String databasePath = await getDatabasesPath();
  String fullPath = "$databasePath/zenlist.db";
  Database db = await openDatabase(
    fullPath,
    version: 2,
    onCreate: (db, version) async {
      await db.execute("CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, quantity INTEGER, price REAL)");
    }
  );
  return db;
}