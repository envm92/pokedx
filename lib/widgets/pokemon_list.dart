import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';
import 'package:pokedx/models/resource.dart';

class PokemonsList extends StatelessWidget {
  final pokemonsBloc;

  final ScrollController _scrollController = ScrollController();

  PokemonsList({Key key, this.pokemonsBloc}) : super(key: key);

  void goToDetail(BuildContext context, Resource pokemon) {
    BlocProvider.of<PokemonBloc>(context)
        .add(DetailRequested(resource: pokemon));
    Navigator.pushNamed(context, '/details');
  }

  ListView _buildList(List<Resource> pokemons) {
    _scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        pokemonsBloc.add(ListRequested());
      }
    });
    return ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: pokemons.length,
        itemBuilder: (BuildContext context, int index) {
          var id = pokemons[index].getId();
          return GestureDetector(
              onTap: () => goToDetail(context, pokemons[index]),
              child: Card(
                child: Container(
                  width: double.infinity,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: CachedNetworkImage(
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) {
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        imageUrl:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${id}.png',
                      )),
                      Expanded(
                          flex: 3,
                          child: ListTile(
                            leading: Text('#${id}'),
                            title: Text(pokemons[index].name.toUpperCase()),
                          ))
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    var _pokemons = <Resource>[];
    return BlocBuilder<PokemonsBloc, PokemonsState>(
        cubit: pokemonsBloc,
        builder: (BuildContext context, PokemonsState state) {
          if (state is PokemonsInitial) {
            pokemonsBloc.add(ListRequested());
            return Center(child: CircularProgressIndicator());
          }

          if (state is ListLoadSuccess) {
            _pokemons = state.pokemons;
          }

          if (state is LoadFailure) {
            return ListTile(title: Text('Error'));
          }
          return Container(child: _buildList(_pokemons));
        });
  }
}
