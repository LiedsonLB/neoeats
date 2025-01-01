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
        await db
            .execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL,
        tipo TEXT CHECK(tipo IN ('cliente', 'gerente')) NOT NULL,
        telefone TEXT,
        data_cadastro TEXT NOT NULL
      );

      CREATE TABLE Mesas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numero INTEGER NOT NULL,
        capacidade INTEGER NOT NULL,
        status TEXT CHECK(status IN ('ocupada', 'disponivel', 'reservada')) NOT NULL
      );

      CREATE TABLE CategoriaDoCardapio (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      );

      CREATE TABLE Pratos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        preco REAL NOT NULL,
        categoria_id INTEGER NOT NULL,
        descricao TEXT,
        disponivel INTEGER NOT NULL CHECK(disponivel IN (0, 1))

        FOREIGN KEY(categoria_id) REFERENCES CategoriaDoCardapio(id)
      );

      CREATE TABLE Ingredientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        item_id INTEGER NOT NULL,
        FOREIGN KEY(item_id) REFERENCES Pratos(id)
      );

      CREATE TABLE Pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cliente_id INTEGER NOT NULL,
        status TEXT CHECK(status IN ('pendente', 'em andamento', 'finalizado', 'cancelado')) NOT NULL,
        data_criacao TEXT NOT NULL,
        data_conclusao TEXT,
        mesa_id INTEGER,
        FOREIGN KEY(cliente_id) REFERENCES Clientes(id),
        FOREIGN KEY(mesa_id) REFERENCES Mesas(id)
      );

      CREATE TABLE PedidosItens (
        pedido_id INTEGER NOT NULL,
        item_id INTEGER NOT NULL,
        quantidade INTEGER NOT NULL,
        preco_unitario REAL NOT NULL,
        PRIMARY KEY (pedido_id, item_id),
        FOREIGN KEY(pedido_id) REFERENCES Pedidos(id),
        FOREIGN KEY(item_id) REFERENCES Pratos(id)
      );

      CREATE TABLE Pagamentos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pedido_id INTEGER NOT NULL,
        valor_total REAL NOT NULL,
        status TEXT CHECK(status IN ('pendente', 'pago', 'cancelado')) NOT NULL,
        data_pagamento TEXT,
        metodo_pagamento TEXT CHECK(metodo_pagamento IN ('dinheiro', 'cartao', 'pix', 'outro')) NOT NULL,
        FOREIGN KEY(pedido_id) REFERENCES Pedidos(id)
      );
    ''');
  }

  Future<void> saveOrder(int clienteId, int mesaId, String status,
      List<Map<String, dynamic>> items) async {
    final db = await instance.database;

    final isoDate = DateTime.now().toIso8601String();

    final orderData = {
      'cliente_id': clienteId,
      'status': status,
      'data_criacao': isoDate,
      'mesa_id': mesaId,
    };

    final orderId = await db.insert('Pedidos', orderData);

    for (var item in items) {
      await db.insert('PedidosItens', {
        'pedido_id': orderId,
        'item_id': item['item_id'],
        'quantidade': item['quantidade'],
        'preco_unitario': item['preco_unitario'],
      });
    }

    print('Pedido salvo com sucesso');
  }

  Future<void> savePayment(int pedidoId, double valorTotal, String status,
      String metodoPagamento) async {
    final db = await instance.database;

    final isoDate = DateTime.now().toIso8601String();

    final paymentData = {
      'pedido_id': pedidoId,
      'valor_total': valorTotal,
      'status': status,
      'data_pagamento': isoDate,
      'metodo_pagamento': metodoPagamento,
    };

    await db.insert('Pagamentos', paymentData);
    print('Pagamento registrado com sucesso');
  }

  Future<List<Map<String, dynamic>>> fetchTables() async {
    final db = await instance.database;
    return await db.query('Mesas');
  }

  Future<List<Map<String, dynamic>>> fetchClients() async {
    final db = await instance.database;
    return await db.query('Clientes');
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final db = await instance.database;
    return await db.query('Pedidos', orderBy: 'data_criacao DESC');
  }

  Future<List<Map<String, dynamic>>> fetchMenuItems() async {
    final db = await instance.database;
    return await db.query('Pratos');
  }

  Future<List<Map<String, dynamic>>> fetchIngredientsForItem(int itemId) async {
    final db = await instance.database;
    return await db
        .query('Ingredientes', where: 'item_id = ?', whereArgs: [itemId]);
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}
