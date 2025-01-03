import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/client_invalid_failure.dart';
import 'package:neoeats/features/data/models/client_model.dart';

class ClientService {
  DatabaseService db = DatabaseService.instance;

  Future<List<Client>> fetchClients() async {
    List<Map<String, dynamic>> results = [];
    try {
      results = await db.query('Client');
    } catch (e) {
      throw ClientInvalidFailure('Clients not found');
    }
    return results.map((map) => Client.fromJson(map)).toList();
  }

  Future<Client> fetchClient(String email) async {
    List<Map<String, dynamic>> results = [];
    List<Map<String, dynamic>> resultsByEmail = [];
    try {
      results = await db.query('Client');
      resultsByEmail = results.where((element) => element['email'] == email).toList();
      if (resultsByEmail.isEmpty) {
        throw ClientInvalidFailure('Client not found');
      }
    } catch (e) {
      throw ClientInvalidFailure('Error fetching client');
    }
    return Client.fromJson(resultsByEmail.first);
  }

  Future<List<Client>> saveClient(Client client) async {
    final Map<String, dynamic> data = client.toJson();
    try {
      await db.insert('Client', data);
    } catch (e) {
      throw ClientInvalidFailure('Error saving client');
    }
    return fetchClients();
  }

  Future<void> updateClient(Client client, String newEmail) async {
    try {
      await db.update(
        'Client',
        {
          'email': newEmail,
        },
        where: 'email = ?',
        whereArgs: [client.email],
      );
    } catch (e) {
      throw ClientInvalidFailure('Error updating client');
    }
  }

  Future<void> deleteClient(int id) async {
    try {
      await db.delete(
        'Client',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw ClientInvalidFailure('Error deleting client');
    }
  }
}
