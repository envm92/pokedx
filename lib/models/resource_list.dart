import 'package:pokedx/models/resource.dart';

class ResourceList {
  int count;
  String next;
  String previous;
  List<Resource> results;

  ResourceList();

  ResourceList.fromMap(Map<String, dynamic> data) {
    count = data['count'];
    next = data['next'];
    previous = data['previous'];
    results = data['results'];
  }
}