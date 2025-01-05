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

      await database.delete('Client');
    });

    tearDown(() async {
      await db.close();
    });

    ClientService clientService = ClientService();

    Client cliente = new Client(name: 'Liedson', email: 'liedson.b9@gmail.com', access: 'client', registrationDate: DateTime.now().toString());

    test('Deve salvar cliente', () async {
      await clientService.saveClient(cliente);

      List<Client> clientes = await clientService.fetchClients();

      expect(clientes.length, 1);
      expect(clientes.first.name, cliente.name);
      expect(clientes.first.email, cliente.email);
    });

    test('Deve pega todos os clientes', () async {
      await clientService.saveClient(cliente);

      List<Client> clientes = await clientService.fetchClients();

      expect(clientes.length, 1);
    });

    test('Deve pega cliente por email', () async {
      await clientService.saveClient(cliente);

      Client clienteFind =  await clientService.fetchClient(cliente.email);

      expect(clienteFind.name, cliente.name);
      expect(clienteFind.email, cliente.email);
    });

    test('Deve atualizar email do cliente', () async {
      await clientService.saveClient(cliente);
      String newEmail = 'newEmail@etest.com';

      await clientService.updateEmailClient(cliente, newEmail);

      List<Client> clientesAtualizados = await clientService.fetchClients();

      expect(clientesAtualizados.length, 1);

      for (var clienteAtualizado in clientesAtualizados) {
        expect(clienteAtualizado.email, newEmail);
      }
    });

    test('Deve deletar cliente', () async {
      await clientService.saveClient(cliente);

      List<Client> clientes = await clientService.fetchClients();

      expect(clientes.length, 1);

      Client clienteFind =  await clientService.fetchClient(cliente.email);

      await clientService.deleteClient(clienteFind.id!);

      final clientesDeleted = await database.query('Client');

      expect(clientesDeleted.length, 0);
    });
  });
}
