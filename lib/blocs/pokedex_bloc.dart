import 'package:pokedx/models/resource.dart';
import 'package:pokedx/resources/pokedex.dart';
import 'package:rxdart/rxdart.dart';

class PokedexBloc {
  final _pokedex = Pokedex();
  final _pokemonFetcher = PublishSubject<List<Resource>>();
  ResourceList _resourceList;
  final List<Resource> _pokemons = [];
  int _offset = 0;

  Stream<List<Resource>> get list => _pokemonFetcher.stream;

  void fetchList() async {
    if (_offset == 0  || (_resourceList != null && _resourceList.next != null)) {
      _resourceList = await _pokedex.fetchPokemons(_offset);
      _offset += 20;
      _pokemons.addAll(_resourceList.results);
      _pokemonFetcher.sink.add(_pokemons);
    }
  }

  void dispose() {
    _pokemonFetcher.close();
  }
}

final bloc = PokedexBloc();