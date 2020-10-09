import 'package:flutter/material.dart';
import 'package:pokedx/services/auth.service.dart';
import 'package:pokedx/services/data.service.dart';

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
      setState(() => _isLoading = false);
    });
  }

  goToDetail(pokemon) {
    Navigator.pushNamed(context, '/details', arguments: pokemon);
  }

  logout() {
    var authSrv = AuthService();
    authSrv
        .logout()
        .then((value) => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedx'),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => logout())
        ],
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () => goToDetail(_pokemons[index]),
                    child: Card(
                      child: ListTile(
                        title: Text(_pokemons[index]['name'].toUpperCase()),
                      ),
                    ));
              }),
    );
  }
}
