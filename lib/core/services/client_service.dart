import 'package:neoeats/core/data/database.dart';
import 'package:neoeats/core/errors/client_invalid_failure.dart';
import 'package:neoeats/features/data/models/client_model.dart';

class ClientService {
  DatabaseService db = DatabaseService.instance;

  Future<List<Client>> fetchClients() async {
    try {
      final List<Map<String, dynamic>> results = await db.query('Client');
      return results.map((map) => Client.fromJson(map)).toList();
    } catch (e) {
      throw ClientInvalidFailure('Clients not found');
    }
  }

  Future<Client> fetchClient(String email) async {
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'Client',
        where: 'email = ?',
        whereArgs: [email],
      );
      if (results.isEmpty) {
        throw ClientInvalidFailure('Client not found');
      }
      return Client.fromJson(results.first);
    } catch (e) {
      throw ClientInvalidFailure('Error fetching client');
    }
  }

  Future<Client> fetchClientById(int id) async {
    try {
      final List<Map<String, dynamic>> results = await db.query(
        'Client',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (results.isEmpty) {
        throw ClientInvalidFailure('Client not found');
      }
      return Client.fromJson(results.first);
    } catch (e) {
      throw ClientInvalidFailure('Error fetching client');
    }
  }

  Future<Client> saveClient(Client client) async {
    final Map<String, dynamic> data = client.toJson();
    try {
      int id = await db.insert('Client', data);
      return client.copyWith(id: id);
    } catch (e) {
      throw ClientInvalidFailure('Error saving client');
    }
    return client;
  }

  Future<void> updateEmailClient(Client client, String newEmail) async {
    try {
      await db.update(
        'Client',
        {'email': newEmail},
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