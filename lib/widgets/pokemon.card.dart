import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {

  Map pokemon;

  PokemonCard(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Text(pokemon['name']),
    );
  }
}