import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokemon/pokemon_event.dart';
import 'package:pokedx/blocs/pokemon/pokemon_state.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent,PokemonState> {
  PokemonsRepository pokemonRepository;

  PokemonBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null), super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {

    if (event is DetailRequested) {
      yield LoadInProgress();
      try {
        final pokemon = await pokemonRepository.getDetail(event.resource);
        yield(LoadSuccess(pokemon: pokemon));
      } catch (error) {
        yield LoadFailure();
      }
    }
  }
}