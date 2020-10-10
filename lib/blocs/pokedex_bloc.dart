import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';
import 'package:pokedx/resources/pokedex.dart';
import 'package:rxdart/rxdart.dart';

class PokedexBloc {
  final _pokedex = Pokedex();
  final _pokemonFetcher = PublishSubject<List<Resource>>();
  final _pokemonDetail = PublishSubject<Pokemon>();
  ResourceList _resourceList;
  final List<Resource> _pokemons = [];
  int _offset = 0;

  Stream<List<Resource>> get list => _pokemonFetcher.stream;
  Stream<Pokemon> get pokemon => _pokemonDetail.stream;

  void fetchList() async {
    if (_offset == 0  || (_resourceList != null && _resourceList.next != null)) {
      _resourceList = await _pokedex.fetchPokemons(_offset);
      _offset += 10;
      _pokemons.addAll(_resourceList.results);
      _pokemonFetcher.sink.add(_pokemons);
    }
  }

  void getDetail(Resource resource) async {
    var result = await _pokedex.getDetail(resource);
    _pokemonDetail.sink.add(result);
  }

  void dispose() {
    _pokemonFetcher.close();
  }
}

final bloc = PokedexBloc();