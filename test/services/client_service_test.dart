import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Client service tests', () {
    late DatabaseService db;
    late Database database;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Cliente');
    });

    tearDown(() async {
      await db.close();
    });

    ClienteService clienteService = ClienteService();

    ClientModel cliente = new ClientModel(nome: 'Liedson', email: 'liedson.b9@gmail.com', acesso: 'gerente', dataCadastro: DateTime.now());

    test('Salvar cliente', () async {
      await clienteService.saveClient(cliente);

      List<ClientModel> clientes = await clienteService.fetchClients();

      expect(clientes.length, 1);
      expect(clientes.first.nome, cliente.nome);
      expect(clientes.first.email, cliente.email);
    });

    test('Pega todos os clientes', () async {
      await clienteService.saveClient(cliente);

      List<ClientModel> clientes = await clienteService.fetchClients();

      expect(clientes.length, 1);
    });

    test('Pega cliente por email', () async {
      await clienteService.saveClient(cliente);

      ClientModel clienteFind =  await clienteService.fetchClient(cliente.email);

      expect(clienteFind.nome, cliente.nome);
      expect(clienteFind.email, cliente.email);
    });

    test('Atualizar email do cliente', () async {
      await clienteService.saveClient(cliente);
      String newEmail = 'newEmail@etest.com';

      await clienteService.updateClient(cliente, newEmail);

      List<ClientModel> clientesAtualizados = await clienteService.fetchClients();

      expect(clientesAtualizados.length, 1);

      for (var clienteAtualizado in clientesAtualizados) {
        expect(clienteAtualizado.email, newEmail);
      }
    });

    test('Deletar cliente', () async {
      await clienteService.saveClient(cliente);

      List<ClientModel> clientes = await clienteService.fetchClients();

      expect(clientes.length, 1);

      ClientModel clienteFind =  await clienteService.fetchClient(cliente.email);

      await clienteService.deleteClient(clienteFind.id!);

      final clientesDeleted = await database.query('Cliente');

      expect(clientesDeleted.length, 0);
    });
  });
}
