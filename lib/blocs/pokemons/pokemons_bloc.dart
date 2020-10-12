import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonEvent,PokemonsState> {
  PokemonsRepository pokemonRepository;

  PokemonsBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null), super(EmptyPokemonsState());

  @override
  Stream<PokemonsState> mapEventToState(PokemonEvent event) async* {
    if (event is LoadPokemons) {
      try {
        final pokemons = await pokemonRepository.fetchPokemons();
        yield(FillPokemonsState(pokemons, pokemons.length));
      } catch (error) { print(error); }
    }
  }
}