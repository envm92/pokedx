import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedx/blocs/pokemon/pokemon_bloc.dart';
import 'package:pokedx/blocs/pokemon/pokemon_event.dart';
import 'package:pokedx/blocs/pokemon/pokemon_state.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  group('PokemonBloc', () {
    MockPokemonsRepository mockPokemonsRepository;
    PokemonBloc pokemonBloc;

    setUp((){
      mockPokemonsRepository = MockPokemonsRepository();
      pokemonBloc = PokemonBloc(pokemonRepository: mockPokemonsRepository);
    });

    tearDown(() {
      pokemonBloc?.close();
    });

    test('throws AssertionError when pokemonRepository is null', () {
      expect(() => PokemonBloc(pokemonRepository: null), throwsAssertionError);
    });

    test('has a correct initial state', () {
      expect(pokemonBloc.state, PokemonInitial());
    });



    group('DetailRequested', () {
      var resource = Resource();
      var pokemon = Pokemon();
      blocTest(
        'emits [LoadInDetailProgress, DetailLoadSuccess] when pokemon repository returns pokemon',
        build: () {
          when(mockPokemonsRepository.getDetail(resource)).thenAnswer(
                (_) => Future.value(pokemon),
          );
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(DetailRequested(resource: resource)),
        expect: [
          LoadInProgress(),
          LoadSuccess(pokemon: pokemon),
        ],
      );
      blocTest(
        'emits [LoadInDetailProgress, LoadFailure] when pokemon repository throws error',
        build: () {
          when(mockPokemonsRepository.getDetail(resource)).thenThrow('');
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(DetailRequested(resource: resource)),
        expect: [
          LoadInProgress(),
          LoadFailure(),
        ],
      );
    });
  });

  group('PokemonsEvents', () {

    group('DetailRequested', () {
      var resource = Resource();
      test('props are [resource]', () {
        expect(DetailRequested(resource: resource).props, [resource]);
      });
    });
  });
}