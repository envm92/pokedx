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
    abilities = data['abilities'].map((ability) => Ability.fromMap(ability)).toList().cast<Ability>();
    base_experience = data['base_experience'];
    forms = data['forms'].map((form) => Resource.fromMap(form) ).toList().cast<Resource>();
    game_indices = data['game_indices'].map((game_index) => GameIndex.fromMap(game_index) ).toList().cast<GameIndex>();
    height = data['height'];
    held_items = data['held_items'].map((held_item) => HeldItem.fromMap(held_item) ).toList().cast<HeldItem>();
    is_default = data['is_default'];
    location_area_encounters = data['location_area_encounters'];
    moves = data['moves'].map((move) => Move.fromMap(move) ).toList().cast<Move>();
    name = data['name'];
    order = data['order'];
    species = Resource.fromMap(data['species']);
    sprites = Sprite.fromMap(data['sprites']);
    stats = data['stats'].map((stat) => Stat.fromMap(stat) ).toList().cast<Stat>();
    types = data['types'].map((type) => Type.fromMap(type) ).toList().cast<Type>();
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
    version_details = data['version_details'].map((version_detail) => VersionDetail.fromMap(version_detail) ).toList().cast<VersionDetail>();
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
    move = (data['move'] != null) ? Resource.fromMap(data['move']) : Resource();
    version_group_details = (data['version'] != null) ? data['version_details'].map((version_group_detail) => VersionGroupDetail.fromMap(version_group_detail) ).toList().cast<VersionGroupDetail>() : [];
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
  Map<String, dynamic> other;
  Map<String, dynamic> versions;

  Sprite.fromMap(Map<String, dynamic> data) {
    back_default = data['back_default'];
    back_female = data['back_female'];
    back_shiny = data['back_shiny'];
    back_shiny_female = data['back_shiny_female'];
    front_default = data['front_default'];
    front_female = data['front_female'];
    front_shiny = data['front_shiny'];
    front_shiny_female = data['front_shiny_female'];
    other = _otherFromMap(data);
    versions = _versionFromMap(data);
  }

  Map<String, dynamic> _otherFromMap (data) {
    return {
      'official_artwork' : {
        'front_default' : data['other']['official-artwork']['front_default']
      }
    };
  }

  Map<String, dynamic> _versionFromMap (data) {
    return {
      'generation-i' : {
        'red-blue' : {
          'back_default': data['versions']['generation-i']['red-blue']['back_default'],
          'back_gray': data['versions']['generation-i']['red-blue']['back_gray'],
          'front_default': data['versions']['generation-i']['red-blue']['front_default'],
          'front_gray': data['versions']['generation-i']['red-blue']['front_gray']
        },
        'yellow' : {
          'back_default': data['versions']['generation-i']['yellow']['back_default'],
          'back_gray': data['versions']['generation-i']['yellow']['back_gray'],
          'front_default': data['versions']['generation-i']['yellow']['front_default'],
          'front_gray': data['versions']['generation-i']['yellow']['front_gray']
        },
      },
      'generation-ii' : {
        'crystal': {
          'back_default': data['versions']['generation-ii']['crystal']['back_default'],
          'back_shiny': data['versions']['generation-ii']['crystal']['back_shiny'],
          'front_default': data['versions']['generation-ii']['crystal']['front_default'],
          'front_shiny': data['versions']['generation-ii']['crystal']['front_shiny']
        },
        'gold': {
          'back_default': data['versions']['generation-ii']['gold']['back_default'],
          'back_shiny': data['versions']['generation-ii']['gold']['back_shiny'],
          'front_default': data['versions']['generation-ii']['gold']['front_default'],
          'front_shiny': data['versions']['generation-ii']['gold']['front_shiny']
        },
        'silver': {
          'back_default': data['versions']['generation-ii']['silver']['back_default'],
          'back_shiny': data['versions']['generation-ii']['silver']['back_shiny'],
          'front_default': data['versions']['generation-ii']['silver']['front_default'],
          'front_shiny': data['versions']['generation-ii']['silver']['front_shiny']
        }
      },
      'generation-iii' : {
        'emerald': {
          'front_default': data['versions']['generation-iii']['emerald']['front_default'],
          'front_shiny': data['versions']['generation-iii']['emerald']['front_shiny']
        },
        'firered-leafgreen': {
          'back_default': data['versions']['generation-iii']['firered-leafgreen']['back_default'],
          'back_shiny': data['versions']['generation-iii']['firered-leafgreen']['back_shiny'],
          'front_default': data['versions']['generation-iii']['firered-leafgreen']['front_default'],
          'front_shiny': data['versions']['generation-iii']['firered-leafgreen']['front_shiny']
        },
        'ruby-sapphire': {
          'back_default': data['versions']['generation-iii']['ruby-sapphire']['back_default'],
          'back_shiny': data['versions']['generation-iii']['ruby-sapphire']['back_shiny'],
          'front_default': data['versions']['generation-iii']['ruby-sapphire']['front_default'],
          'front_shiny': data['versions']['generation-iii']['ruby-sapphire']['front_shiny']
        }
      },
      'generation-iv' : {
        'diamond-pearl': {
          'back_default': data['versions']['generation-iv']['diamond-pearl']['back_default'],
          'back_female': data['versions']['generation-iv']['diamond-pearl']['back_female'],
          'back_shiny': data['versions']['generation-iv']['diamond-pearl']['back_shiny'],
          'back_shiny_female': data['versions']['generation-iv']['diamond-pearl']['back_shiny_female'],
          'front_default': data['versions']['generation-iv']['diamond-pearl']['front_default'],
          'front_female': data['versions']['generation-iv']['diamond-pearl']['front_female'],
          'front_shiny': data['versions']['generation-iv']['diamond-pearl']['front_shiny'],
          'front_shiny_female': data['versions']['generation-iv']['diamond-pearl']['front_shiny_female']
        },
        'heartgold-soulsilver': {
          'back_default': data['versions']['generation-iv']['heartgold-soulsilver']['back_default'],
          'back_female': data['versions']['generation-iv']['heartgold-soulsilver']['back_female'],
          'back_shiny': data['versions']['generation-iv']['heartgold-soulsilver']['back_shiny'],
          'back_shiny_female': data['versions']['generation-iv']['heartgold-soulsilver']['back_shiny_female'],
          'front_default': data['versions']['generation-iv']['heartgold-soulsilver']['front_default'],
          'front_female': data['versions']['generation-iv']['heartgold-soulsilver']['front_female'],
          'front_shiny': data['versions']['generation-iv']['heartgold-soulsilver']['front_shiny'],
          'front_shiny_female': data['versions']['generation-iv']['heartgold-soulsilver']['front_shiny_female']
        },
        'platinum': {
          'back_default': data['versions']['generation-iv']['platinum']['back_default'],
          'back_female': data['versions']['generation-iv']['platinum']['back_female'],
          'back_shiny': data['versions']['generation-iv']['platinum']['back_shiny'],
          'back_shiny_female': data['versions']['generation-iv']['platinum']['back_shiny_female'],
          'front_default': data['versions']['generation-iv']['platinum']['front_default'],
          'front_female': data['versions']['generation-iv']['platinum']['front_female'],
          'front_shiny': data['versions']['generation-iv']['platinum']['front_shiny'],
          'front_shiny_female': data['versions']['generation-iv']['platinum']['front_shiny_female']
        }
      },
      'generation-v' : {
        'black-white': {
          'animated': {
            'back_default': data['versions']['generation-v']['black-white']['animated']['back_default'],
            'back_female': data['versions']['generation-v']['black-white']['animated']['back_female'],
            'back_shiny': data['versions']['generation-v']['black-white']['animated']['back_shiny'],
            'back_shiny_female': data['versions']['generation-v']['black-white']['animated']['back_shiny_female'],
            'front_default': data['versions']['generation-v']['black-white']['animated']['front_default'],
            'front_female': data['versions']['generation-v']['black-white']['animated']['front_female'],
            'front_shiny': data['versions']['generation-v']['black-white']['animated']['front_shiny'],
            'front_shiny_female': data['versions']['generation-v']['black-white']['animated']['front_shiny_female']
          },
          'back_default': data['versions']['generation-v']['black-white']['back_default'],
          'back_female': data['versions']['generation-v']['black-white']['back_female'],
          'back_shiny': data['versions']['generation-v']['black-white']['back_shiny'],
          'back_shiny_female': data['versions']['generation-v']['black-white']['back_shiny_female'],
          'front_default': data['versions']['generation-v']['black-white']['front_default'],
          'front_female': data['versions']['generation-v']['black-white']['front_female'],
          'front_shiny': data['versions']['generation-v']['black-white']['front_shiny'],
          'front_shiny_female': data['versions']['generation-v']['black-white']['front_shiny_female']
        }
      },
      'generation-vi' : {
        'omegaruby-alphasapphire': {
          'front_default': data['versions']['generation-vi']['omegaruby-alphasapphire']['front_default'],
          'front_female': data['versions']['generation-vi']['omegaruby-alphasapphire']['front_female'],
          'front_shiny': data['versions']['generation-vi']['omegaruby-alphasapphire']['front_shiny'],
          'front_shiny_female': data['versions']['generation-vi']['omegaruby-alphasapphire']['front_shiny_female']
        },
        'x-y': {
          'front_default': data['versions']['generation-vi']['x-y']['front_default'],
          'front_female': data['versions']['generation-vi']['x-y']['front_female'],
          'front_shiny': data['versions']['generation-vi']['x-y']['front_shiny'],
          'front_shiny_female': data['versions']['generation-vi']['x-y']['front_shiny_female']
        }
      },
      'generation-vii' : {
        'icons': {
          'front_default': data['versions']['generation-vii']['icons']['front_default'],
          'front_female': data['versions']['generation-vii']['icons']['front_female']
        },
        'ultra-sun-ultra-moon': {
          'front_default': data['versions']['generation-vii']['ultra-sun-ultra-moon']['front_default'],
          'front_female': data['versions']['generation-vii']['ultra-sun-ultra-moon']['front_female'],
          'front_shiny': data['versions']['generation-vii']['ultra-sun-ultra-moon']['front_shiny'],
          'front_shiny_female': data['versions']['generation-vii']['ultra-sun-ultra-moon']['front_shiny_female']
        }
      },
      'generation-viii' : {
        'icons': {
          'front_default': data['versions']['generation-viii']['icons']['front_default'],
          'front_female': data['versions']['generation-viii']['icons']['front_female']
        }
      },
    };
  }

  List<Map<String, String>> getDefault() {
    if (back_default != null) {
      return [
        {'name': 'Front', 'url': front_default},
        {'name': 'Back', 'url': back_default},
      ];
    }
    return [];
  }

  List<Map<String, String>> getFemale() {
    if (back_female != null) {
      return [
        {'name': 'Front female', 'url': front_female},
        {'name': 'Back female', 'url': back_female}
      ];
    }
    return [];
  }

  List<Map<String, String>> getShiny() {
    if (back_shiny != null) {
      return [
        {'name': 'Front shiny', 'url': front_shiny},
        {'name': 'Back shiny', 'url': back_shiny}
      ];
    }
    return [];
  }

  List<Map<String, String>> getShinyFemale() {
    if (back_shiny_female != null) {
      return [
        {'name': 'Front shiny female', 'url': front_shiny_female},
        {'name': 'Back shiny female', 'url': back_shiny_female}
      ];
    }
    return [];
  }

  List<Map<String, String>> getOther() {
    if (other['official_artwork']['front_default'] != null) {
      return [{'name': '', 'url': other['official_artwork']['front_default']}];
    }
    return [];
  }

  Map<String, dynamic> getVersion() {
    var sprintsVersions = {};
    var list = <Map<String,String>>[];
    var currVersion = {};
    if (versions['generation-i']['red-blue']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-i']['red-blue']['front_default']});
    }
    if (versions['generation-i']['red-blue']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-i']['red-blue']['back_default']});
    }
    if (versions['generation-i']['red-blue']['front_gray'] != null) {
      list.add({'name': 'Front Gray', 'url': versions['generation-i']['red-blue']['front_gray']});
    }
    if (versions['generation-i']['red-blue']['back_gray'] != null) {
      list.add({'name': 'Back Gray', 'url': versions['generation-i']['red-blue']['back_gray']});
    }

    if (list.isNotEmpty) {
      currVersion['red-blue'] = {
        'name' : 'Red Blue',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-i']['yellow']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-i']['yellow']['front_default']});
    }
    if (versions['generation-i']['yellow']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-i']['yellow']['back_default']});
    }
    if (versions['generation-i']['yellow']['front_gray'] != null) {
      list.add({'name': 'Front Gray', 'url': versions['generation-i']['yellow']['front_gray']});
    }
    if (versions['generation-i']['yellow']['back_gray'] != null) {
      list.add({'name': 'Gray', 'url': versions['generation-i']['yellow']['back_gray']});
    }

    if (list.isNotEmpty) {
      currVersion['yellow'] = {
        'name' : 'Yellow',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-i'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-ii']['crystal']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-ii']['crystal']['front_default']});
    }
    if (versions['generation-ii']['crystal']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-ii']['crystal']['back_default']});
    }
    if (versions['generation-ii']['crystal']['front_gray'] != null) {
      list.add({'name': 'Front Gray ', 'url': versions['generation-ii']['crystal']['front_gray']});
    }
    if (versions['generation-ii']['crystal']['back_gray'] != null) {
      list.add({'name': 'Back Gray ', 'url': versions['generation-ii']['crystal']['back_gray']});
    }

    if (list.isNotEmpty) {
      currVersion['crystal'] = {
        'name' : 'Crystal',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-ii']['gold']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-ii']['gold']['front_default']});
    }
    if (versions['generation-ii']['gold']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-ii']['gold']['back_default']});
    }
    if (versions['generation-ii']['gold']['front_gray'] != null) {
      list.add({'name': 'Front Gray ', 'url': versions['generation-ii']['gold']['front_gray']});
    }
    if (versions['generation-ii']['gold']['back_gray'] != null) {
      list.add({'name': 'Back Gray ', 'url': versions['generation-ii']['gold']['back_gray']});
    }

    if (list.isNotEmpty) {
      currVersion['gold'] = {
        'name' : 'Gold',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-ii']['silver']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-ii']['silver']['front_default']});
    }
    if (versions['generation-ii']['silver']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-ii']['silver']['back_default']});
    }
    if (versions['generation-ii']['silver']['front_gray'] != null) {
      list.add({'name': 'Front Gray ', 'url': versions['generation-ii']['silver']['front_gray']});
    }
    if (versions['generation-ii']['silver']['back_gray'] != null) {
      list.add({'name': 'Back Gray ', 'url': versions['generation-ii']['silver']['back_gray']});
    }

    if (list.isNotEmpty) {
      currVersion['silver'] = {
        'name' : 'Silver',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-ii'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-iii']['emerald']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iii']['emerald']['front_default']});
    }
    if (versions['generation-iii']['emerald']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iii']['emerald']['front_shiny']});
    }

    if (list.isNotEmpty) {
      currVersion['emerald'] = {
        'name' : 'Emerald',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-iii']['firered-leafgreen']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iii']['firered-leafgreen']['front_default']});
    }
    if (versions['generation-iii']['firered-leafgreen']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-iii']['firered-leafgreen']['back_default']});
    }
    if (versions['generation-iii']['firered-leafgreen']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iii']['firered-leafgreen']['front_shiny']});
    }
    if (versions['generation-iii']['firered-leafgreen']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-iii']['firered-leafgreen']['back_shiny']});
    }

    if (list.isNotEmpty) {
      currVersion['firered-leafgreen'] = {
        'name' : 'Firered Leafgreen',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-iii']['ruby-sapphire']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iii']['ruby-sapphire']['front_default']});
    }
    if (versions['generation-iii']['ruby-sapphire']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-iii']['ruby-sapphire']['back_default']});
    }
    if (versions['generation-iii']['ruby-sapphire']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iii']['ruby-sapphire']['front_shiny']});
    }
    if (versions['generation-iii']['ruby-sapphire']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-iii']['ruby-sapphire']['back_shiny']});
    }

    if (list.isNotEmpty) {
      currVersion['ruby-sapphire'] = {
        'name' : 'Ruby Sapphire',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-iii'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-iv']['diamond-pearl']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iv']['diamond-pearl']['front_default']});
    }
    if (versions['generation-iv']['diamond-pearl']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-iv']['diamond-pearl']['back_default']});
    }
    if (versions['generation-iv']['diamond-pearl']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-iv']['diamond-pearl']['front_female']});
    }
    if (versions['generation-iv']['diamond-pearl']['back_female'] != null) {
      list.add({'name': 'Back female', 'url': versions['generation-iv']['diamond-pearl']['back_female']});
    }
    if (versions['generation-iv']['diamond-pearl']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iv']['diamond-pearl']['front_shiny']});
    }
    if (versions['generation-iv']['diamond-pearl']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-iv']['diamond-pearl']['back_shiny']});
    }
    if (versions['generation-iv']['diamond-pearl']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-iv']['diamond-pearl']['front_shiny_female']});
    }
    if (versions['generation-iv']['diamond-pearl']['back_shiny_female'] != null) {
      list.add({'name': 'Back shiny female', 'url': versions['generation-iv']['diamond-pearl']['back_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['diamond-pearl'] = {
        'name' : 'Diamond Pearl',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-iv']['heartgold-soulsilver']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iv']['heartgold-soulsilver']['front_default']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-iv']['heartgold-soulsilver']['back_default']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-iv']['heartgold-soulsilver']['front_female']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['back_female'] != null) {
      list.add({'name': 'Back female', 'url': versions['generation-iv']['heartgold-soulsilver']['back_female']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iv']['heartgold-soulsilver']['front_shiny']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-iv']['heartgold-soulsilver']['back_shiny']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-iv']['heartgold-soulsilver']['front_shiny_female']});
    }
    if (versions['generation-iv']['heartgold-soulsilver']['back_shiny_female'] != null) {
      list.add({'name': 'Back shiny female', 'url': versions['generation-iv']['heartgold-soulsilver']['back_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['heartgold-soulsilver'] = {
        'name' : 'Heartgold Soulsilver',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-iv']['platinum']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-iv']['platinum']['front_default']});
    }
    if (versions['generation-iv']['platinum']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-iv']['platinum']['back_default']});
    }
    if (versions['generation-iv']['platinum']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-iv']['platinum']['front_female']});
    }
    if (versions['generation-iv']['platinum']['back_female'] != null) {
      list.add({'name': 'Back female', 'url': versions['generation-iv']['platinum']['back_female']});
    }
    if (versions['generation-iv']['platinum']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-iv']['platinum']['front_shiny']});
    }
    if (versions['generation-iv']['platinum']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-iv']['platinum']['back_shiny']});
    }
    if (versions['generation-iv']['platinum']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-iv']['platinum']['front_shiny_female']});
    }
    if (versions['generation-iv']['platinum']['back_shiny_female'] != null) {
      list.add({'name': 'Back shiny female', 'url': versions['generation-iv']['platinum']['back_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['platinum'] = {
        'name' : 'Platinum',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }
    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-iv'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-v']['black-white']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-v']['black-white']['front_default']});
    }
    if (versions['generation-v']['black-white']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-v']['black-white']['back_default']});
    }
    if (versions['generation-v']['black-white']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-v']['black-white']['front_female']});
    }
    if (versions['generation-v']['black-white']['back_female'] != null) {
      list.add({'name': 'Back female', 'url': versions['generation-v']['black-white']['back_female']});
    }
    if (versions['generation-v']['black-white']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-v']['black-white']['front_shiny']});
    }
    if (versions['generation-v']['black-white']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-v']['black-white']['back_shiny']});
    }
    if (versions['generation-v']['black-white']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-v']['black-white']['front_shiny_female']});
    }
    if (versions['generation-v']['black-white']['back_shiny_female'] != null) {
      list.add({'name': 'Back shiny female', 'url': versions['generation-v']['black-white']['back_shiny_female']});
    }

    if (versions['generation-v']['black-white']['animated']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-v']['black-white']['animated']['front_default']});
    }
    if (versions['generation-v']['black-white']['animated']['back_default'] != null) {
      list.add({'name': 'Back', 'url': versions['generation-v']['black-white']['animated']['back_default']});
    }
    if (versions['generation-v']['black-white']['animated']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-v']['black-white']['animated']['front_female']});
    }
    if (versions['generation-v']['black-white']['animated']['back_female'] != null) {
      list.add({'name': 'Back female', 'url': versions['generation-v']['black-white']['animated']['back_female']});
    }
    if (versions['generation-v']['black-white']['animated']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-v']['black-white']['animated']['front_shiny']});
    }
    if (versions['generation-v']['black-white']['animated']['back_shiny'] != null) {
      list.add({'name': 'Back shiny', 'url': versions['generation-v']['black-white']['animated']['back_shiny']});
    }
    if (versions['generation-v']['black-white']['animated']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-v']['black-white']['animated']['front_shiny_female']});
    }
    if (versions['generation-v']['black-white']['animated']['back_shiny_female'] != null) {
      list.add({'name': 'Back shiny female', 'url': versions['generation-v']['black-white']['animated']['back_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['black-white'] = {
        'name' : 'Black White',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }
    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-v'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-vi']['omegaruby-alphasapphire']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-vi']['omegaruby-alphasapphire']['front_default']});
    }
    if (versions['generation-vi']['omegaruby-alphasapphire']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-vi']['omegaruby-alphasapphire']['front_female']});
    }
    if (versions['generation-vi']['omegaruby-alphasapphire']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-vi']['omegaruby-alphasapphire']['front_shiny']});
    }
    if (versions['generation-vi']['omegaruby-alphasapphire']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-vi']['omegaruby-alphasapphire']['front_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['omegaruby-alphasapphire'] = {
        'name' : 'Omegaruby-alphasapphire',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-vi']['x-y']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-vi']['x-y']['front_default']});
    }
    if (versions['generation-vi']['x-y']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-vi']['x-y']['front_female']});
    }
    if (versions['generation-vi']['x-y']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-vi']['x-y']['front_shiny']});
    }
    if (versions['generation-vi']['x-y']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-vi']['x-y']['front_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['x-y'] = {
        'name' : 'X Y',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-vi'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-vii']['icons']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-vii']['icons']['front_default']});
    }
    if (versions['generation-vii']['icons']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-vii']['icons']['front_female']});
    }

    if (list.isNotEmpty) {
      currVersion['icons'] = {
        'name' : 'Icons',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if (versions['generation-vii']['ultra-sun-ultra-moon']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-vii']['ultra-sun-ultra-moon']['front_default']});
    }
    if (versions['generation-vii']['ultra-sun-ultra-moon']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-vii']['ultra-sun-ultra-moon']['front_female']});
    }
    if (versions['generation-vii']['ultra-sun-ultra-moon']['front_shiny'] != null) {
      list.add({'name': 'Front shiny', 'url': versions['generation-vii']['ultra-sun-ultra-moon']['front_shiny']});
    }
    if (versions['generation-vii']['ultra-sun-ultra-moon']['front_shiny_female'] != null) {
      list.add({'name': 'Front shiny female', 'url': versions['generation-vii']['ultra-sun-ultra-moon']['front_shiny_female']});
    }

    if (list.isNotEmpty) {
      currVersion['ultra-sun-ultra-moon'] = {
        'name' : 'Ultra Sun Ultra Moon',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-vii'] = {...currVersion};
      currVersion = {};
    }

    if (versions['generation-viii']['icons']['front_default'] != null) {
      list.add({'name': 'Front', 'url': versions['generation-viii']['icons']['front_default']});
    }
    if (versions['generation-viii']['icons']['front_female'] != null) {
      list.add({'name': 'Front female', 'url': versions['generation-viii']['icons']['front_female']});
    }

    if (list.isNotEmpty) {
      currVersion['icons'] = {
        'name' : 'Icons',
        'sprint' : [...list]
      };
      list = <Map<String,String>>[];
    }

    if(currVersion.isNotEmpty) {
      sprintsVersions['generation-viii'] = {...currVersion};
      currVersion = {};
    }
    return Map<String, dynamic>.from(sprintsVersions);
  }
}
class Stat {
  int base_stat;
  int effort;
  Resource stat;

  Stat.fromMap(Map<String, dynamic> data) {
    base_stat = data['base_stat'];
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