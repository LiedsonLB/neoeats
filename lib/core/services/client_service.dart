import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/client_invalid_failure.dart';
import 'package:neoeats/features/data/models/client_model.dart';

class ClienteService {
  DatabaseService db = DatabaseService.instance;

  Future<List<ClientModel>> fetchClients() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Cliente');
    } catch (e) {
      ClientInvalidFailure('Clients not found');
    }
    return results.map((map) => ClientModel.fromJson(map)).toList();
  }

  Future<ClientModel> fetchClient(String email) async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Cliente');
    } catch (e) {
      ClientInvalidFailure('Client not found');
    }
    return results.map((map) => ClientModel.fromJson(map)).first;
  }

  Future<List<ClientModel>> saveClient(ClientModel client) async {
    final Map<String, dynamic> data = client.toJson();
    await db.insert('Cliente', data);
    return fetchClients();
  }

  Future<void> updateClient(ClientModel client, String email) async {
    await db.update(
      'Cliente',
      {
        'email': email,
      },
      where: 'email = ?',
      whereArgs: [client.email],
    );
  }

  Future<void> deleteClient(int id) async {
    await db.delete(
      'Cliente',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
