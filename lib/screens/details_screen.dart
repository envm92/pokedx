import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_state.dart';
import 'package:pokedx/models/pokemon.dart';

class DetailsScreen extends StatelessWidget {

  Widget _buildSprites(Pokemon pokemon) {
    var sprites = pokemon.sprites;
    var spriteList = [
      ...sprites.getOther(),
      ...sprites.getDefault(),
      ...sprites.getFemale(),
      ...sprites.getShiny(),
      ...sprites.getShinyFemale()
    ];
    sprites.getVersion().forEach((key, value) {
      value.forEach((k,v) {
        spriteList = [...spriteList, ...v['sprint']];
      });
    });
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        color: Colors.blueGrey.shade50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: spriteList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      placeholder: (context, url) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      imageUrl: spriteList[index]['url'],
                    ),
                  ),
                  Text(spriteList[index]['name'])
                ],
              );
            }));
  }

  DataTable _buildGeneralDataTable(Pokemon pokemon) {
    return DataTable(
        columns: const <DataColumn>[
          DataColumn( label: Text('Name',),),
          DataColumn( label: Text('Value',),),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Base Experience')),
              DataCell(Text('${pokemon.base_experience}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Height')),
              DataCell(Text('${pokemon.height}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Order')),
              DataCell(Text('${pokemon.order}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Weight')),
              DataCell(Text('${pokemon.weight}')),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Species')),
              DataCell(Text('${pokemon.species.name.toUpperCase()}')),
            ],
          ),
        ]
    );
  }

  DataTable _buildStatsDataTable(Pokemon pokemon) {
    return DataTable(
        columns: const <DataColumn>[
          DataColumn( label: Text('Name',),),
          DataColumn( label: Text('Base',),),
          DataColumn( label: Text('Effort',),),
        ],
        rows: pokemon.stats.map((value) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(value.stat.name.toUpperCase())),
              DataCell(Text('${value.base_stat}')),
              DataCell(Text('${value.effort}')),
            ],
          );
        }).toList()
    );
  }

  List<Widget> _buildList(Pokemon pokemon) {
      var _details = [];
      _details.add(ListTile(title: Text('General info')));
      _details.add(_buildGeneralDataTable(pokemon));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Abilities')));
      var abilities = <Widget>[];
      pokemon.abilities.forEach((v) {
        abilities.add(Chip(label: Text(v.ability.name)));
      });
      _details.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: abilities,
        ),
      ));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Forms')));
      var forms = <Widget>[];
      pokemon.forms.forEach((v) {
        forms.add(Chip(label: Text(v.name)));
      });
      _details.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: forms,
        ),
      ));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Moves')));
      var moves = <Widget>[];
      pokemon.moves.forEach((v) {
        moves.add(Chip(label: Text(v.move.name)));
      });
      _details.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: moves,
        ),
      ));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Stats')));
      _details.add(_buildStatsDataTable(pokemon));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Type')));
      var type = <Widget>[];
      pokemon.types.forEach((v) {
        type.add(Chip(label: Text(v.type.name)));
      });
      _details.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: type,
        ),
      ));
      return _details.cast<Widget>();
  }

  Widget _buildDetail(Pokemon pokemon) {
    return Scaffold(
      appBar: AppBar(
        title: Text('# ${pokemon.id} ${pokemon.name.toUpperCase()}'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child:_buildSprites(pokemon)
            ),
            Expanded(
              child: Container(
                child: ListView(
                  padding: const EdgeInsets.all(5),
                  children: _buildList(pokemon),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      cubit: BlocProvider.of<PokemonBloc>(context),
      builder: (BuildContext context, PokemonState state ){
        if (state is LoadSuccess) {
          return _buildDetail(state.pokemon);
        }

        if (state is LoadFailure) {
          return Scaffold(
            body: Center(child: Text('Error')),
          );
        }

        if (state is LoadInProgress) {

          return _buildLoading();
        }

        return Container();
      },
    );
  }
}