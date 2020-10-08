import 'package:flutter/material.dart';
import 'package:pokedx/services/data.service.dart';
import 'package:pokedx/widgets/pokemon.card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeScreen> {

  List _pokemons = List();
  DataService _service = DataService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _service.fetchPokemon().then((result) {
      _pokemons = result;
      setState(() => _isLoading = false );
    });
  }

  goToDetail(pokemon) {
    Navigator.pushNamed(context, '/details', arguments: pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedx'),
      ),
      body: (_isLoading)?  Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _pokemons.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => goToDetail(_pokemons[index]),
              child: PokemonCard(_pokemons[index]),
            );
          }
      ),
    );
  }
}