import 'package:http/http.dart' as http;
import 'dart:convert';

const LIMIT = '1050';
const URI = 'pokeapi.co';
class DataService {

  Future<List<dynamic>> fetchPokemon() {
    return http.get(Uri.https(URI, 'api/v2/pokemon/', {
      'limit': LIMIT
    })).then((response) {
      var res = json.decode(response.body);
      if (res['results'] != null) {
        return res['results'];
      }
      return [];
    });
  }

  Future<Map> getDetail(String pokemonName) {
    return http.get(Uri.https(URI, 'api/v2/pokemon/${pokemonName}')).then((response) {
      var res = json.decode(response.body);
      return res;
    });
  }
}