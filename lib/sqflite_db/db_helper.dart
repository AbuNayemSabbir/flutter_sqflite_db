import 'package:flutter_sqflite_db/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;

  DBHelper.internal();

  static Database? _db;

  Future<Database> get db async {
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
CREATE TABLE User(
id INTEGER PRIMARY KEY,
name TEXT,
email TEXT
)

''');
  }

  Future<int> insertUser(User user) async {
    final db_client = await db;
    return db_client.insert('User', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final dbclient = await db;
    final List<Map<String, dynamic>> maps = await dbclient.query('User');
    return List.generate(
        maps.length,
        (index) => User(
            id: maps[index]['id'],
            name: maps[index]['name'],
            email: maps[index]['email']));
  }

  Future<int> updateUser(User user) async {
    final dbClient = await db;
    return await dbClient.update(
      'User',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final dbClient = await db;
    return await dbClient.delete(
      'User',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
