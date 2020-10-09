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
    abilities = data['abilities'].map((ability) => Ability.fromMap(ability) ).toList();
    base_experience = data['base_experience'];
    forms = data['forms'].map((form) => Resource.fromMap(form) ).toList();
    game_indices = data['game_indices'].map((game_index) => GameIndex.fromMap(game_index) ).toList();
    height = data['height'];
    held_items = data['held_items'].map((held_item) => HeldItem.fromMap(held_item) ).toList();
    is_default = data['is_default'];
    location_area_encounters = data['location_area_encounters'];
    moves = data['moves'].map((move) => Move.fromMap(move) ).toList();
    name = data['name'];
    order = data['order'];
    species = Resource.fromMap(data['species']);
    sprites = Sprite.fromMap(data['sprites']);
    stats = data['stats'].map((stat) => Stat.fromMap(stat) ).toList();
    types = data['types'].map((type) => Type.fromMap(type) ).toList();
    weight = data['weight'];
  }
}
class Ability {
  Resource ability;
  bool is_hidden;
  int slot;

  Ability.fromMap(Map<String, dynamic> data) {
    ability = Resource.fromMap(data['ability']);
    is_hidden = data['is_hidden'];
    slot = data['slot'];
  }
}
class GameIndex {
  int game_index;
  Resource version;

  GameIndex.fromMap(Map<String, dynamic> data) {
    game_index = data['game_index'];
    version = Resource.fromMap(data['version']);
  }
}
class HeldItem {
  Resource item;
  List<VersionDetail> version_details;

  HeldItem.fromMap(Map<String, dynamic> data) {
    item = Resource.fromMap(data['item']);
    version_details = data['version_details'].map((version_detail) => VersionDetail.fromMap(version_detail) ).toList();
  }
}
class VersionDetail {
  int rarity;
  Resource version;

  VersionDetail.fromMap(Map<String, dynamic> data) {
    rarity = data['rarity'];
    version = Resource.fromMap(data['version']);
  }
}
class Move {
  Resource move;
  List<VersionGroupDetail> version_group_details;

  Move.fromMap(Map<String, dynamic> data) {
    move = Resource.fromMap(data['version']);
    version_group_details = data['version_details'].map((version_group_detail) => VersionGroupDetail.fromMap(version_group_detail) ).toList();
  }
}
class VersionGroupDetail {
  int level_learned_at;
  Resource move_learn_method;
  Resource version_group;

  VersionGroupDetail.fromMap(Map<String, dynamic> data) {
    level_learned_at = data['level_learned_at'];
    move_learn_method = Resource.fromMap(data['move_learn_method']);
    version_group = Resource.fromMap(data['version_group']);
  }
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

  Sprite.fromMap(Map<String, dynamic> data) {
    back_default = data['back_default'];
    back_female = data['back_female'];
    back_shiny = data['back_shiny'];
    back_shiny_female = data['back_shiny_female'];
    front_default = data['front_default'];
    front_female = data['front_female'];
    front_shiny = data['front_shiny'];
    front_shiny_female = data['front_shiny_female'];
    other = data['other'];
    versions = data['versions'];
  }
}
class Stat {
  int base_tat;
  int effort;
  Resource stat;

  Stat.fromMap(Map<String, dynamic> data) {
    base_tat = data['base_tat'];
    effort = data['effort'];
    stat = Resource.fromMap(data['stat']);
  }
}
class Type {
  int slot;
  Resource type;

  Type.fromMap(Map<String, dynamic> data) {
    slot = data['slot'];
    type = Resource.fromMap(data['type']);
  }
}