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

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        acesso TEXT CHECK(acesso IN ('cliente', 'gerente')) NOT NULL,
        telefone TEXT,
        data_cadastro TEXT NOT NULL
      );

      CREATE TABLE Mesa (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        capacidade INTEGER NOT NULL,
        status TEXT CHECK(status IN ('livre', 'ocupada')) NOT NULL
      );

      CREATE TABLE Categoria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL UNIQUE
      );

      CREATE TABLE Prato (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        imagem TEXT,
        descricao TEXT,
        preco REAL NOT NULL,
        id_categoria INTEGER NOT NULL,
        status TEXT CHECK(status IN ('ativo', 'inativo')) NOT NULL,

        FOREIGN KEY (id_categoria) REFERENCES Categoria (id)
      );

      CREATE TABLE Favorito (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_cliente INTEGER NOT NULL,
        id_prato INTEGER NOT NULL,

        FOREIGN KEY (id_cliente) REFERENCES Clientes (id),
        FOREIGN KEY (id_prato) REFERENCES Prato (id)
      );

      CREATE TABLE Pedido (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_mesa INTEGER NOT NULL,
        data_pedido TEXT NOT NULL,
        status TEXT CHECK(status IN ('aberto', 'fechado')) NOT NULL,

        FOREIGN KEY (id_mesa) REFERENCES Mesa (id)
      );

      CREATE TABLE PedidoPrato (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_pedido INTEGER NOT NULL,
        id_prato INTEGER NOT NULL,
        quantidade INTEGER NOT NULL,
        preco_unitario REAL NOT NULL,

        FOREIGN KEY (id_pedido) REFERENCES Pedido (id),
        FOREIGN KEY (id_prato) REFERENCES Prato (id)
      );

      CREATE TABLE Pagamento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_pedido INTEGER NOT NULL,
        valor REAL NOT NULL,
        data_pagamento TEXT NOT NULL,
        tipo_pagamento TEXT CHECK(tipo_pagamento IN ('dinheiro', 'cartao', 'pix')) NOT NULL,

        FOREIGN KEY (id_pedido) REFERENCES Pedido (id)
      );

    ''');
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);
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
