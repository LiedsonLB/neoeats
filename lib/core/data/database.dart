import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    _database ??= await _initDB('neoeats.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    await db.execute('PRAGMA foreign_keys = ON;');
    return db;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Client (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL,
      access TEXT CHECK(access IN ('client', 'manager')) NOT NULL,
      phone TEXT,
      registration_date TEXT NOT NULL
    );

    CREATE TABLE RestaurantTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      capacity INTEGER NOT NULL,
      status TEXT CHECK(status IN ('free', 'occupied')) NOT NULL
    );

    CREATE TABLE Category (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE
    );

    CREATE TABLE Dish (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      image TEXT,
      description TEXT,
      price REAL NOT NULL,
      status TEXT CHECK(status IN ('active', 'inactive')) NOT NULL
    );

    CREATE TABLE DishCategory (
      dish_id INTEGER NOT NULL,
      category_id INTEGER NOT NULL,
      PRIMARY KEY (dish_id, category_id),
      FOREIGN KEY (dish_id) REFERENCES Dish(id) ON DELETE CASCADE,
      FOREIGN KEY (category_id) REFERENCES Category(id)
    );

    CREATE TABLE Favorite (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      client_id INTEGER NOT NULL,
      dish_id INTEGER NOT NULL,
      FOREIGN KEY (client_id) REFERENCES Client(id) ON DELETE CASCADE,
      FOREIGN KEY (dish_id) REFERENCES Dish(id)
    );

    CREATE TABLE OrderDish (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_id INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      order_date TEXT NOT NULL,
      status TEXT CHECK(status IN ('open', 'closed')) NOT NULL,
      order_number TEXT NOT NULL,
      FOREIGN KEY (table_id) REFERENCES RestaurantTable(id)
    );

    CREATE TABLE OrderItem (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id INTEGER NOT NULL,
      dish_id INTEGER NOT NULL,
      quantity INTEGER NOT NULL,
      unit_price REAL NOT NULL,
      FOREIGN KEY (order_id) REFERENCES OrderDish(id),
      FOREIGN KEY (dish_id) REFERENCES Dish(id)
    );

    CREATE TABLE Payment (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id INTEGER NOT NULL,
      amount REAL NOT NULL,
      payment_date TEXT NOT NULL,
      payment_type TEXT CHECK(payment_type IN ('cash', 'card', 'pix')) NOT NULL,
      FOREIGN KEY (order_id) REFERENCES OrderDish(id)
    );
  ''');
  }

  Future<List<Map<String, dynamic>>> query(
    String table, {
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}