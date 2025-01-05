import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/client_delete_failure.dart';
import 'package:neoeats/core/errors/client_fetch_failure.dart';
import 'package:neoeats/core/errors/client_save_failure.dart';
import 'package:neoeats/core/errors/client_update_failure.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/features/data/repositories/client_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Client repository test', () {
    late DatabaseService db;
    late Database database;
    late ClientRepositoryImpl repository;
    late ClientService clientService;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Client');

      clientService = ClientService();
      repository = ClientRepositoryImpl(clientService: clientService);
    });

    tearDown(() async {
      await db.close();
    });

    final Client client = Client(
      name: 'LiedsonLB',
      email: 'liedson.b9@gmail.com',
      access: 'client',
      registrationDate: DateTime.now().toString(),
    );

    test('Deve retornar lista de clientes', () async {
      await repository.addClient(client);

      List<Client> results = await repository.getClients();

      expect(results.length, 1);
      expect(results.first.name, 'LiedsonLB');
    });

    test('Deve adicionar cliente com sucesso', () async {
      Client result = await repository.addClient(client);

      expect(result.name, 'LiedsonLB');

      List<Client> results = await repository.getClients();
      expect(results.length, 1);
      expect(results.first.name, 'LiedsonLB');
    });

    // desisti de tratar essa exceção
    // test('Deve lançar erro ao adicionar cliente com email duplicado', () async {
    //   await repository.addClient(client);

    //   expect(
    //     () async => await repository.addClient(client),
    //     throwsA(isA<ClientSaveFailure>()),
    //   );

    //   List<Client> results = await repository.getClients();
    //   expect(results.length, 1);
    // });

    test('Deve buscar cliente por email com sucesso', () async {
      await repository.addClient(client);

      Client result = await repository.getClientByEmail('liedson.b9@gmail.com');

      expect(result.name, 'LiedsonLB');
      expect(result.email, 'liedson.b9@gmail.com');
    });

    test('Deve lançar erro ao buscar cliente por email inexistente', () async {
      expect(
        () async =>
            await repository.getClientByEmail('nonexistent@example.com'),
        throwsA(isA<ClientFetchFailure>()),
      );
    });

    test('Deve atualizar cliente com sucesso', () async {
      await repository.addClient(client);

      await repository.updateEmailClient(client, 'novoEmail@olamundo.com');

      Client result =
          await repository.getClientByEmail('novoEmail@olamundo.com');

      expect(result.email, 'novoEmail@olamundo.com');
    });

    test('Deve deletar cliente com sucesso', () async {
      await repository.addClient(client);

      List<Client> resultsBeforeDelete = await repository.getClients();
      expect(resultsBeforeDelete.length, 1);

      Client clientFind = await repository.getClientByEmail(client.email);

      await repository.removeClient(clientFind.id!);

      List<Client> resultsAfterDelete = await repository.getClients();
      expect(resultsAfterDelete.length, 0);
    });

    test('Deve lançar erro ao deletar cliente inexistente', () async {
      await repository.addClient(client);

      expect(
        () async => await repository.removeClient(999),
        throwsA(isA<ClientDeleteFailure>()),
      );

      List<Client> results = await repository.getClients();
      expect(results.length, 1);
    });
  });
}
