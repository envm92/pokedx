class Resource {
  String name = '';
  String url = '';

  Resource();

  Resource.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    url = data['url'];
  }
}

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
    results = data['results'].map((result) {
      return Resource.fromMap(result);
    } ).toList().cast<Resource>();
  }
}