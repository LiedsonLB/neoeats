import 'package:neoeats/core/errors/client_delete_failure.dart';
import 'package:neoeats/core/errors/client_fetch_failure.dart';
import 'package:neoeats/core/errors/client_save_failure.dart';
import 'package:neoeats/core/errors/client_update_failure.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/core/services/client_service.dart';
import 'package:neoeats/features/domain/repositories/client_repository.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientService _clientService;

  ClientRepositoryImpl({required ClientService clientService})
      : _clientService = clientService;

  @override
  Future<List<Client>> getClients() async {
    try {
      return await _clientService.fetchClients();
    } catch (e) {
      throw ClientFetchFailure('Failed to fetch clients');
    }
  }

  @override
  Future<Client> getClientByEmail(String email) async {
    try {
      return await _clientService.fetchClient(email);
    } catch (e) {
      throw ClientFetchFailure('Failed to fetch client with email: $email');
    }
  }

  @override
  Future<Client> addClient(Client client) async {
    try {
      return await _clientService.saveClient(client);
    } catch (e) {
      return throw ClientSaveFailure('Failed to save client: ${client.name}');
    }
  }

  @override
  Future<void> updateEmailClient(Client client, String newEmail) async {
    try {
      await _clientService.updateEmailClient(client, newEmail);
    } catch (e) {
      throw ClientUpdateFailure('Failed to update client: ${client.name}');
    }
  }

  @override
  Future<void> removeClient(int id) async {
    try {
      final client = await _clientService.fetchClientById(id);
      if (client == null) {
        throw ClientDeleteFailure('Client not found');
      }
      await _clientService.deleteClient(id);
    } catch (e) {
      throw ClientDeleteFailure('Failed to delete client with id: $id');
    }
  }
}
