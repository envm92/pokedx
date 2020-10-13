import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonEvent,PokemonsState> {
  PokemonsRepository pokemonRepository;

  PokemonsBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null), super(PokemonInitial());

  @override
  Stream<PokemonsState> mapEventToState(PokemonEvent event) async* {

    if (event is ListRequested) {
      yield LoadInProgress();
      try {
        final pokemons = await pokemonRepository.fetchPokemons();
        yield(ListLoadSuccess(pokemons: pokemons));
      } catch (error) {
        yield LoadFailure();
      }
    }

    if (event is DetailRequested) {
      yield LoadInDetailProgress();
      try {
        final pokemon = await pokemonRepository.getDetail(event.resource);
        yield(DetailLoadSuccess(pokemon: pokemon));
      } catch (error) {
        yield LoadFailure();
      }
    }
  }
}