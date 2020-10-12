import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';
import 'package:pokedx/models/resource.dart';

class PokemonsList extends StatelessWidget {
  final pokemonsBloc;

  final ScrollController _scrollController = ScrollController();

  PokemonsList({Key key, this.pokemonsBloc}) : super(key: key);

  void goToDetail(BuildContext context, Resource pokemon) {
    Navigator.pushNamed(context, '/details', arguments: pokemon);
  }

  ListView _buildList(List<Resource> pokemons) {
    _scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        pokemonsBloc.add(LoadPokemons());
      }
    });
    return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => goToDetail(context, pokemons[index]),
              child: Card(
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(pokemons[index].name.toUpperCase()),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsBloc, PokemonsState>(
        cubit: pokemonsBloc,
        builder: (BuildContext context, PokemonsState state ){
          if (state is EmptyPokemonsState) {
            pokemonsBloc.add(LoadPokemons());
            return Center(child: CircularProgressIndicator());
          }
          if (state is FillPokemonsState) {
              return _buildList(state.pokemons);
          }
          return ListTile(title: Text('Error'));
        }
    );
  }

}
