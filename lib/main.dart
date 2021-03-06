import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_repository.dart';
import 'package:pokedx/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/routes.dart';
import 'package:pokedx/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final pokemonRepository = PokemonsRepository();
  final authRepository = AuthRepository();


  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<PokemonsBloc>(
        create: (BuildContext context) =>
            PokemonsBloc(pokemonRepository: pokemonRepository),
      ),
      BlocProvider<PokemonBloc>(
        create: (BuildContext context) =>
            PokemonBloc(pokemonRepository: pokemonRepository),
      ),
      BlocProvider<AuthBloc>(
        create: (BuildContext context) =>
            AuthBloc(authRepository: authRepository),
      ),
    ],
    child: PokedxApp(),
  ));
}

class PokedxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: customTheme, routes: Routes.get(), home: Routes.getHome(context));
  }
}
