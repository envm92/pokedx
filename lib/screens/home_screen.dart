import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokedx/services/auth_service.dart';
import 'package:pokedx/widgets/pokemon_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  void logout() {
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
      body: PokemonsList(pokemonsBloc: BlocProvider.of<PokemonsBloc>(context))
    );
  }
}
