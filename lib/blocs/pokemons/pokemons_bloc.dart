import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent,PokemonsState> {
  PokemonsRepository pokemonRepository;

  PokemonsBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null), super(PokemonsInitial());

  @override
  Stream<PokemonsState> mapEventToState(PokemonsEvent event) async* {

    if (event is ListRequested) {
      yield LoadInProgress();
      try {
        final pokemons = await pokemonRepository.fetchPokemons();
        yield(ListLoadSuccess(pokemons: pokemons));
      } catch (error) {
        yield LoadFailure();
      }
    }

  }
}