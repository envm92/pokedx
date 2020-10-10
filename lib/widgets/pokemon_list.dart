import 'package:flutter/material.dart';
import 'package:pokedx/blocs/pokedex_bloc.dart';
import 'package:pokedx/models/resource.dart';

class PokemonList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  void goToDetail(BuildContext context, Resource pokemon) {
    Navigator.pushNamed(context, '/details', arguments: pokemon);
  }

  Widget _buildList(AsyncSnapshot<List<Resource>> snapshot) {
    return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () => goToDetail(context, snapshot.data[index]),
              child: Card(
                child: ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(snapshot.data[index].name.toUpperCase()),
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchList();
    _scrollController.addListener(() {
      var triggerFetchMoreSize =
          0.9 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        bloc.fetchList();
      }
    });
    return StreamBuilder(
        stream: bloc.list,
        builder:
            (BuildContext context, AsyncSnapshot<List<Resource>> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
