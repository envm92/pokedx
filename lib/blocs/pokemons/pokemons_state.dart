import 'package:equatable/equatable.dart';
import 'package:pokedx/models/resource.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();
}

class EmptyPokemonsState extends PokemonsState {
  final List<Resource> pokemons = [];

  @override
  List<Object> get props => [pokemons];
}

class FillPokemonsState extends PokemonsState {
  final List<Resource> pokemons;
  final int offset;

  FillPokemonsState (this.pokemons, this.offset);

  @override
  List<Object> get props => [pokemons, offset];
}