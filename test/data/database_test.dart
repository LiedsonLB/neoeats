import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:neoeats/core/data/database.dart';
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
    });

    tearDown(() async {
      await db.close();
    });

    test('iniciar banco de dados', () async {
      expect(database, isA<Database>());
    });
  });
}
