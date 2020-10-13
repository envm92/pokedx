import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedx/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokedx/blocs/pokemons/pokemons_event.dart';
import 'package:pokedx/blocs/pokemons/pokemons_repository.dart';
import 'package:pokedx/blocs/pokemons/pokemons_state.dart';
import 'package:pokedx/models/pokemon.dart';
import 'package:pokedx/models/resource.dart';

class MockPokemonsRepository extends Mock implements PokemonsRepository {}

void main() {
  group('PokemonsBloc', () {
    MockPokemonsRepository mockPokemonsRepository;
    PokemonsBloc pokemonsBloc;

    setUp((){
      mockPokemonsRepository = MockPokemonsRepository();
      pokemonsBloc = PokemonsBloc(pokemonRepository: mockPokemonsRepository);
    });

    tearDown(() {
      pokemonsBloc?.close();
    });

    test('throws AssertionError when pokemonRepository is null', () {
      expect(() => PokemonsBloc(pokemonRepository: null), throwsAssertionError);
    });

    test('has a correct initial state', () {
      expect(pokemonsBloc.state, PokemonInitial());
    });

    group('ListRequested', () {
      blocTest(
        'emits [LoadInProgress, ListLoadSuccess] when pokemon repository returns list',
        build: () {
          when(mockPokemonsRepository.fetchPokemons()).thenAnswer(
                (_) => Future.value([]),
          );
          return pokemonsBloc;
        },
        act: (bloc) => bloc.add(ListRequested()),
        expect: [
          LoadInProgress(),
          ListLoadSuccess(pokemons: []),
        ],
      );
      blocTest(
        'emits [LoadInProgress, LoadFailure] when pokemon repository throws error',
        build: () {
          when(mockPokemonsRepository.fetchPokemons()).thenThrow('');
          return pokemonsBloc;
        },
        act: (bloc) => bloc.add(ListRequested()),
        expect: [
          LoadInProgress(),
          LoadFailure(),
        ],
      );
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
          return pokemonsBloc;
        },
        act: (bloc) => bloc.add(DetailRequested(resource: resource)),
        expect: [
          LoadInDetailProgress(),
          DetailLoadSuccess(pokemon: pokemon),
        ],
      );
      blocTest(
        'emits [LoadInDetailProgress, LoadFailure] when pokemon repository throws error',
        build: () {
          when(mockPokemonsRepository.getDetail(resource)).thenThrow('');
          return pokemonsBloc;
        },
        act: (bloc) => bloc.add(DetailRequested(resource: resource)),
        expect: [
          LoadInDetailProgress(),
          LoadFailure(),
        ],
      );
    });
  });

  group('PokemonsEvents', () {
    group('ListRequested', () {
      test('props are []', () {
        expect(ListRequested().props, []);
      });
    });

    group('DetailRequested', () {
      var resource = Resource();
      test('props are [resource]', () {
        expect(DetailRequested(resource: resource).props, [resource]);
      });
    });
  });
}