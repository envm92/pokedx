import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';

const URI = 'pokeapi.co';

class DataService {
  Future<ResourceList> fetchPokemons(int offset, { limit = 10 }) {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/',
            {'limit': limit.toString(), 'offset': offset.toString()}))
        .then((response) {
      var resourceList = ResourceList.fromMap(json.decode(response.body));
      return resourceList;
    });
  }

  Future<Pokemon> getDetail(String pokemonName) {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/${pokemonName}'))
        .then((response) {
      return Pokemon.fromMap(json.decode(response.body));
    });
  }
}
