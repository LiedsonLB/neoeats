import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/restaurant_table_fetch_failure.dart';
import 'package:neoeats/core/errors/restaurant_table_save_failure.dart';
import 'package:neoeats/features/data/models/restaurant_table_model.dart';

class RestaurantTableService {
  DatabaseService db = DatabaseService.instance;

  Future<RestaurantTable> saveTable(RestaurantTable table) async {
    final Map<String, dynamic> data = table.toJson();
    try {
      final tableId = await db.insert('RestaurantTable', data);
      return table.copyWith(id: tableId);
    } catch (e) {
      print("Error while saving table: $e");
      throw RestaurantTableSaveFailure('Error saving restaurant table');
    }
  }

  Future<RestaurantTable> fetchTableById(int id) async {
    List<Map<String, dynamic>> results;
    try {
      results = await db.query(
        'RestaurantTable',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (results.isEmpty) {
        throw RestaurantTableFetchFailure('Restaurant table not found');
      }
    } catch (e) {
      throw RestaurantTableFetchFailure('Error fetching restaurant table');
    }

    return RestaurantTable.fromJson(results.first);
  }

  Future<List<RestaurantTable>> fetchAllTables() async {
    List<Map<String, dynamic>> results;
    try {
      results = await db.query('RestaurantTable');
    } catch (e) {
      throw RestaurantTableFetchFailure('Error fetching restaurant tables');
    }

    return results.map((map) {
      return RestaurantTable.fromJson(map);
    }).toList();
  }

  Future<void> updateTableStatus(int id, String status) async {
    try {
      final result = await db.update(
        'RestaurantTable',
        {'status': status},
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result == 0) {
        throw RestaurantTableSaveFailure('Error updating restaurant table status');
      }
    } catch (e) {
      throw RestaurantTableSaveFailure('Error updating restaurant table status');
    }
  }
}
