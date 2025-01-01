import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Database tests', () {
    late DatabaseService db;
    late Database database;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Clientes');
      await database.delete('Pedidos');
      await database.delete('Mesas');
      await database.delete('ItensDoCardapio');
      await database.delete('Ingredientes');
      await database.delete('Pagamentos');
    });

    tearDown(() async {
      await db.close();
    });

    Future<void> inserirCliente({
      required String nome,
      required String email,
      required String tipo,
    }) async {
      await database.insert('Clientes', {
        'nome': nome,
        'email': email,
        'tipo': tipo,
        'data_cadastro': DateTime.now().toIso8601String(),
      });
    }

    Future<void> inserirMesa({required int numero, required int capacidade, required String status}) async {
      await database.insert('Mesas', {
        'numero': numero,
        'capacidade': capacidade,
        'status': status,
      });
    }

    test('Salvar cliente', () async {
      inserirCliente(
          nome: 'Cliente 1', email: 'cliente1@email.com', tipo: 'cliente');
      inserirCliente(
          nome: 'Cliente 2', email: 'cliente2@email.com', tipo: 'cliente');
      inserirCliente(
          nome: 'Cliente 2', email: 'cliente2@email.com', tipo: 'gerente');

      final clientes = await database.query('Clientes');

      for (var cliente in clientes) {
        print(cliente);
      }

      expect(clientes.length, 3);
      expect(clientes.first['nome'], 'Cliente 1');
      expect(clientes.first['email'], 'cliente1@email.com');
    });

    test('Salvar mesa', () async {
      await inserirMesa(numero: 1, capacidade: 5, status: 'ocupada');

      final mesas = await database.query('Mesas');

      expect(mesas.length, 1);
      expect(mesas.first['numero'], 1);
    });

    test('Salvar pedido', () async {
      await inserirCliente(nome: 'Liedson', email: 'liedson@email.com', tipo: 'cliente');
      await inserirMesa(numero: 1, capacidade: 5, status: 'ocupada');

      try {
        final cliente = await database.query('Clientes', where: 'id = ?', whereArgs: [2]);
      } catch (e) {
        throw Exception('Cliente não existe: $e');
      }

      try {
        final mesa = await database.query('Mesas', where: 'id = ?', whereArgs: [2]);
      } catch (e) {
        throw Exception('Mesa não existe: $e');
      }

      final pedido = {
        'cliente_id': 1,
        'status': 'em andamento',
        'data_criacao': '2024-12-31',
        'mesa_id': 1,
      };

      await database.insert('Pedidos', pedido);
      final pedidos = await database.query('Pedidos');

      expect(pedidos.length, 1);
      expect(pedidos.first['status'], 'Em andamento');
    });

    test('Salvar item do cardápio', () async {
      final itemCardapio = {
        'nome': 'Pizza Margherita',
        'categoria': 'Pizza',
        'preco': 25.99,
        'disponivel': 1,
      };

      await database.insert('ItensDoCardapio', itemCardapio);
      final itens = await database.query('ItensDoCardapio');

      expect(itens.length, 1);
      expect(itens.first['nome'], 'Pizza Margherita');
      expect(itens.first['preco'], 25.99);
    });

    test('Salvar ingrediente', () async {
      final ingrediente = {
        'nome': 'Mussarela',
        'item_id': 1,
      };

      await database.insert('Ingredientes', ingrediente);
      final ingredientes = await database.query('Ingredientes');

      expect(ingredientes.length, 1);
      expect(ingredientes.first['nome'], 'Mussarela');
    });

    test('Salvar pagamento', () async {
      await inserirCliente(
          nome: 'Liedson', email: 'liedson@email.com', tipo: 'cliente');
      final pedido = {
        'cliente_id': 1,
        'status': 'finalizado',
        'data_criacao': '2024-12-31',
        'mesa_id': 1,
      };

      await database.insert('Pedidos', pedido);
      final pagamento = {
        'pedido_id': 1,
        'valor_total': 50.00,
        'status': 'pendente',
        'data_pagamento': DateTime.now().toIso8601String(),
        'metodo_pagamento': 'dinheiro',
      };

      await database.insert('Pagamentos', pagamento);
      final pagamentos = await database.query('Pagamentos');

      expect(pagamentos.length, 1);
      expect(pagamentos.first['valor_total'], 50.00);
    });

    test('Buscar clientes', () async {
      await inserirCliente(
          nome: 'Maria', email: 'maria@email.com', tipo: 'gerente');
      final clientes = await database.query('Clientes');

      expect(clientes.length, 1);
      expect(clientes.first['nome'], 'Maria');
    });

    test('Buscar pedidos por cliente', () async {
      await inserirCliente(
          nome: 'Carlos', email: 'carlos@email.com', tipo: 'cliente');
      final pedido = {
        'cliente_id': 1,
        'status': 'finalizado',
        'data_criacao': '2024-12-31',
        'mesa_id': 1,
      };

      await database.insert('Pedidos', pedido);
      final pedidos = await database
          .query('Pedidos', where: 'cliente_id = ?', whereArgs: [1]);

      expect(pedidos.length, 1);
      expect(pedidos.first['status'], 'Concluído');
    });

    test('Buscar itens do cardápio', () async {
      final itemCardapio = {
        'nome': 'Coca-Cola',
        'categoria': 'Bebidas',
        'preco': 4.99,
        'disponivel': 1,
      };

      await database.insert('ItensDoCardapio', itemCardapio);
      final itens = await database.query('ItensDoCardapio');

      expect(itens.length, 1);
      expect(itens.first['nome'], 'Coca-Cola');
    });

    test('Fechar banco de dados', () async {
      await db.close();

      try {
        await database.query('Clientes');
      } catch (e) {
        expect(e, isA<DatabaseException>());
      }
    });
  });
}
