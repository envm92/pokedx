import 'package:pokedx/models/resource.dart';
import 'package:pokedx/providers/data_provider.dart';

class PokemonsRepository {
  final dataServices = DataProvider();
  List<Resource> pokemons = [];
  int count = 0;

  Future<List<Resource>>  fetchPokemons() {
    return dataServices.fetchPokemons(count).then((ResourceList resourceList) {
      pokemons.addAll(resourceList.results);
      count = pokemons.length;
      return pokemons;
    });
  }
}