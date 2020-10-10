import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokedex_bloc.dart';
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';

class DetailsScreen extends StatelessWidget {
  final Resource resource;

  DetailsScreen(this.resource);

  Widget _buildSprites(Pokemon pokemon) {
    var sprites = pokemon.sprites;
    var spriteList = [...sprites.getDefault(), ...sprites.getFemale(), ...sprites.getShiny(), ...sprites.getShinyFemale()];
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

  List<Widget> _buildList(Pokemon pokemon) {
      var _details = [];
      _details.add(ListTile(
        title: Text('Base Experience'),
        subtitle: Text('${pokemon.base_experience}'),
      ));
      _details.add(ListTile(
        title: Text('Height'),
        subtitle: Text('${pokemon.height}'),
      ));
      _details.add(ListTile(
        title: Text('Order'),
        subtitle: Text('${pokemon.order}'),
      ));
      _details.add(ListTile(
        title: Text('Weight'),
        subtitle: Text('${pokemon.weight}'),
      ));
      _details.add(ListTile(
        title: Text('Species'),
        subtitle: Text('${pokemon.species.name}'),
      ));
      _details.add(Divider());
      _details.add(ListTile(title: Text('Abilities')));
      var abilities = <Widget>[];
      pokemon.abilities.forEach((v) {
        abilities.add(Chip(label: Text(v.ability.name)));
      });
      _details.add(Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: abilities,
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
      var stats = <Widget>[];
      pokemon.stats.forEach((v) {
        stats.add(Chip(
            label: Text('${v.stat.name} B: ${v.base_stat} E: ${v.effort}')));
      });
      _details.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: stats,
        ),
      ));
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
  Widget _buildDetail(AsyncSnapshot<Pokemon> snapshot) {
    var pokemon = snapshot.data;
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
    bloc.getDetail(resource);
    return StreamBuilder(
        stream: bloc.pokemon,
        builder:
            (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
          if (snapshot.hasData) {
            return _buildDetail(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return _buildLoading();
        });
  }
}