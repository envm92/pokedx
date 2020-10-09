import 'package:pokedx/models/resource.dart';
import 'package:pokedx/services/data_service.dart';

class Pokedex {
  final dataServices = DataService();
  Future<ResourceList>  fetchPokemons([int offset = 0]) => dataServices.fetchPokemons(offset);
}