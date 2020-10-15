import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/models/pokemon.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();
  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class LoadInProgress extends PokemonState {}

class LoadSuccess  extends PokemonState{
  final Pokemon pokemon;

  LoadSuccess({@required this.pokemon});

  @override
  List<Object> get props => [pokemon];
}

class LoadFailure extends PokemonState {}
