import 'package:pokedx/models/resource.dart';

class Pokemon {
  int id;
  List<Ability> abilities;
  int base_experience;
  List<Resource> forms;
  List<GameIndex> game_indices;
  int height;
  List<HeldItem> held_items;
  bool is_default;
  String location_area_encounters;
  List<Move> moves;
  String name;
  int order;
  Resource species;
  Sprite sprites;
  List<Stat> stats;
  List<Type> types;
  int weight;

  Pokemon();

  Pokemon.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    abilities = data['abilities'];
  }
}
class Ability {
  Resource ability;
  bool is_hidden;
  int slot;
}
class GameIndex {
  int game_index;
  Resource version;
}
class HeldItem {
  Resource item;
  List<VersionDetail> version_details;
}
class VersionDetail {
  int rarity;
  Resource version;
}
class Move {
  Resource move;
  List<VersionGroupDetail> version_group_details;
}
class VersionGroupDetail {
  int level_learned_at;
  Resource move_learn_method;
  Resource version_group;
}
class Specie {
  String name;
  String url;
}
class Sprite {
  String back_default;
  String back_female;
  String back_shiny;
  String back_shiny_female;
  String front_default;
  String front_female;
  String front_shiny;
  String front_shiny_female;
  Map<String, Map<String, String>> other;
  Map<String, Map<String, String>> versions;
}
class Stat {
  int base_tat;
  int effort;
  Resource stat;
}
class Type {
  int slot;
  Resource type;
}