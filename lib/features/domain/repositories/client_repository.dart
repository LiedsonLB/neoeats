import 'package:neoeats/features/data/models/client_model.dart';

abstract class ClientRepository {
  Future<List<Client>> getClients();
  Future<Client> getClientByEmail(String email);
  Future<Client> addClient(Client client);
  Future<void> updateEmailClient(Client client, String newEmail);
  Future<void> removeClient(int id);
}