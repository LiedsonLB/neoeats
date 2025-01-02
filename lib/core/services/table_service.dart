import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/features/data/models/table_model.dart';

class TableService {
  DatabaseService db = DatabaseService.instance;

  Future<TableModel> saveTable(TableModel table) async {
    final Map<String, dynamic> data = table.toMap();
    await db.insert('Mesa', data);
    return table;
  }
  
  Future<List<TableModel>> fetchTables() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Mesa');
    } catch (e) {
      print('Erro ao buscar mesas');
    }
    return results.map((map) => TableModel.fromMap(map)).toList();
  }

  Future<TableModel> fetchTable(int id) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Mesa');
    } catch (e) {
      print('Erro ao buscar mesa');
    }
    return results.map((map) => TableModel.fromMap(map)).first;
  }

  Future<void> updateTable(TableModel table, String id) async {
    await db.update(
      'Mesa',
      {
        'id': id,
      },
      where: 'id = ?',
      whereArgs: [table.id],
    );
  }

  Future<void> deleteTable(int id) async {
    await db.delete(
      'Mesa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}