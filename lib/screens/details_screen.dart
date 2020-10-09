import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedx/services/data_service.dart';

class DetailsScreen extends StatefulWidget {
  final Map pokemon;

  DetailsScreen(this.pokemon);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<DetailsScreen> {
  bool _isLoading = true;
  Map _detail;
  List _sprites = [];
  final List<Widget> _details = [];
  final DataService _service = DataService();

  @override
  void initState() {
    super.initState();
    /*_service.getDetail(widget.pokemon['name']).then((value) {
      _detail = value;
      getSprites();
      getDetail();
    });*/
  }

  void getSprites() {
    var sprites = _detail['sprites'];
    final filteredMap = Map.from(sprites)
      ..removeWhere((k, v) {
        if (v == null) {
          return true;
        }
        if (v.runtimeType == String) {
          return false;
        }
        return true;
      });
    _sprites = filteredMap.entries
        .map((e) => {'name': e.key, 'url': e.value})
        .toList();
  }

  void getDetail() {
    _details.add(ListTile(
      title: Text('Base Experience'),
      subtitle: Text(_detail['base_experience'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Height'),
      subtitle: Text(_detail['height'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Order'),
      subtitle: Text(_detail['order'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Weight'),
      subtitle: Text(_detail['weight'].toString()),
    ));
    _details.add(ListTile(
      title: Text('Species'),
      subtitle: Text(_detail['species']['name'].toString()),
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Abilities')));
    var abilities = <Widget>[];
    _detail['abilities'].forEach((v) {
      abilities.add(Chip(label: Text(v['ability']['name'])));
    });
    _details.add(Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: abilities,
    ));
    _details.add(Divider());
    _details.add(ListTile(title: Text('Forms')));
    var forms = <Widget>[];
    _detail['forms'].forEach((v) {
      forms.add(Chip(label: Text(v['name'])));
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
    _detail['moves'].forEach((v) {
      moves.add(Chip(label: Text(v['move']['name'])));
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
    _detail['stats'].forEach((v) {
      stats.add(Chip(
          label: Text(v['stat']['name'] + ': ' + v['base_stat'].toString())));
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
    _detail['types'].forEach((v) {
      type.add(Chip(label: Text(v['type']['name'])));
    });
    _details.add(Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 6.0,
        runSpacing: 6.0,
        children: type,
      ),
    ));
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((_isLoading)
            ? widget.pokemon['name'].toUpperCase()
            : '#' +
                _detail['id'].toString() +
                ' ' +
                _detail['name'].toUpperCase()),
      ),
      body: (_isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        color: Colors.blueGrey.shade50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _sprites.length,
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
                                      imageUrl: _sprites[index]['url'],
                                    ),
                                  ),
                                  Text(_sprites[index]['name'])
                                ],
                              );
                            })),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: ListView(
                        padding: const EdgeInsets.all(5),
                        children: _details,
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
    );
  }
}
