import 'package:flutter/material.dart';
import 'package:pokedx/services/data.service.dart';

class DetailsScreen extends StatefulWidget {

  Map pokemon;

  DetailsScreen(this.pokemon);

  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<DetailsScreen> {

  Map _detail;
  DataService _service = DataService();

  @override
  void initState() {
    super.initState();
    _service.getDetail(widget.pokemon['name']).then((value) => _detail = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon['name']),
      ),
      body: Text(widget.pokemon['name']),
    );
  }

}