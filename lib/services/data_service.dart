import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource_list.dart';

const LIMIT = '20';
const URI = 'pokeapi.co';

class DataService {
  Future<ResourceList> fetchPokemon([int offset = 0]) {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/',
            {'limit': LIMIT, 'offset': offset.toString()}))
        .then((response) {
      var resourceList = ResourceList.fromMap(json.decode(response.body));
      return resourceList;
    });
  }

  Future<Pokemon> getDetail(String pokemonName) {
    return http
        .get(Uri.https(URI, 'api/v2/pokemon/${pokemonName}'))
        .then((response) {
      var res = json.decode(response.body);
      return res;
    });
  }
}
