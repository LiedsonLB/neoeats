import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/services/table_service.dart';
import 'package:neoeats/features/data/models/table_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Table service tests', () {
    late DatabaseService db;
    late Database database;

    setUp(() async {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        sqfliteFfiInit();
      }

      databaseFactory = databaseFactoryFfi;
      db = DatabaseService.instance;
      database = await db.database;

      await database.delete('Mesa');
    });

    tearDown(() async {
      await db.close();
    });

    TableService tableService = TableService();

    TableModel table = new TableModel(id: 1, capacidade: 4, status: 'livre');

    test('Salvar mesa', () async {
      TableModel tableSaved = await tableService.saveTable(table);

      List<TableModel> mesas = await tableService.fetchTables();

      print('informações da mesa: ${mesas.first.id} - ${mesas.first.capacidade} - ${mesas.first.status}');

      expect(mesas.length, 1);
      expect(mesas.first.id, 1);
      expect(mesas.first.status, 'livre');
      expect(mesas.first.capacidade, 4);
    });
  });
}