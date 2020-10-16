import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/models/resource.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class DetailRequested extends PokemonEvent {
  final Resource resource;
  const DetailRequested({@required this.resource}) : assert(resource != null);

  @override
  List<Object> get props => [resource];
}