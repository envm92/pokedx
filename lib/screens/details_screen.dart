import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_state.dart';
import 'package:pokedx/models/pokemon.dart';

class DetailsScreen extends StatelessWidget {

  Widget _buildSprint(Map<String, String> item) {
    if (item != null) {
      return Expanded(
          child: CachedNetworkImage(
            fit: BoxFit.fitHeight,
            placeholder: (context, url) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            imageUrl: item['url'],
          ));
    }
    return Container();
  }

  List<Widget>_buildCardSprite(String category, List<Map<String, String>> listCategory) {
    var list = <Widget>[];
    if(listCategory.isNotEmpty) {
      list.add(ListTile(title: Text(category),));
      list.add(Card(
        child: Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Row(
            children: listCategory.map((e) => _buildSprint(e)).toList(),
          ),
        ),
      ));
    }
    return list;
  }

  Widget _buildSprites(Pokemon pokemon) {
    var sprites = pokemon.sprites;
    var list = <Widget>[];
    list.addAll(_buildCardSprite('Default',sprites.getDefault()));
    list.addAll(_buildCardSprite('Female',sprites.getFemale()));
    list.addAll(_buildCardSprite('Shiny',sprites.getShiny()));
    list.addAll(_buildCardSprite('Shiny female',sprites.getShinyFemale()));

    sprites.getVersion().forEach((key, value) {
      value.forEach((k,v) {
        list.addAll(_buildCardSprite(v['name'],v['sprint']));
      });
    });
    return ListView.builder(
        key: PageStorageKey('sprints'),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        });
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

  Widget _buildAbilities(Pokemon pokemon){
    var abilities = <Widget>[];
    pokemon.abilities.forEach((v) {
      abilities.add(Chip(label: Text(v.ability.name)));
    });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: abilities,
      ),
    );

  }

  Widget _buildForms(Pokemon pokemon) {
    var forms = <Widget>[];
    pokemon.forms.forEach((v) {
      forms.add(Chip(label: Text(v.name)));
    });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: forms,
      ),
    );
  }

  Widget _buildMoves(Pokemon pokemon) {
    var moves = <Widget>[];
    pokemon.moves.forEach((v) {
      moves.add(Chip(label: Text(v.move.name)));
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: moves,
        ),
      ),
    );
  }

  Widget _buildType(Pokemon pokemon) {
    var type = <Widget>[];
    pokemon.types.forEach((v) {
      type.add(Chip(label: Text(v.type.name)));
    });
   return Padding(
     padding: const EdgeInsets.all(10),
     child: Wrap(
       spacing: 6.0,
       runSpacing: 6.0,
       children: type,
     ),
   );
  }

  Widget _buildDetail(BuildContext context,Pokemon pokemon) {
    return DefaultTabController(length: 7,child: Scaffold(
      appBar: AppBar(
        title: Text('# ${pokemon.id} ${pokemon.name.toUpperCase()}'),
      ),
      body: Container(
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
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
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    _buildGeneralDataTable(pokemon),
                    _buildSprites(pokemon),
                    _buildAbilities(pokemon),
                    _buildForms(pokemon),
                    _buildMoves(pokemon),
                    _buildStatsDataTable(pokemon),
                    _buildType(pokemon),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 40.0,
        child: TabBar(
          labelColor: Theme.of(context).accentColor,
          isScrollable: true,
          tabs: [
            Text('General'),
            Text('Sprints'),
            Text('Abilities'),
            Text('Forms'),
            Text('Moves'),
            Text('Stats'),
            Text('Type'),
          ],
        ),
      )
      )
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
          return _buildDetail(context, state.pokemon);
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