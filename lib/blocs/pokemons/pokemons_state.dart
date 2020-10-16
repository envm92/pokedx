import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();
  @override
  List<Object> get props => [];
}

class PokemonsInitial extends PokemonsState {}

class LoadInProgress extends PokemonsState {}
class DetailLoadInProgress extends PokemonsState {}

class ListLoadSuccess extends PokemonsState {
  final List<Resource> pokemons;

  ListLoadSuccess ({@required this.pokemons})
      : assert(pokemons != null);

  @override
  List<Object> get props => [pokemons];
}

class DetailLoadSuccess  extends PokemonsState{
  final Pokemon pokemon;

  DetailLoadSuccess({@required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class LoadFailure extends PokemonsState {}
class DetailLoadFailure extends PokemonsState {}
