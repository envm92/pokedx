# Welcome to Eri's Pokedex

![Image of Sylveon](https://media.giphy.com/media/FiSdfE2aD9ihO/source.gif)

You can try me here <https://pokedx-25dec.web.app/>

This project is a pokedex, encyclopedia of Pokémon.

## To test in your device

Install a Flutter app on an attached device. Write the next commands in the terminal in the root of this project

```
$ flutter pub get
$ flutter install
```

You have to had attached a device (preference Android) and has set up Flutter environment <https://flutter.dev/docs/get-started/install>


## Plugins used

|Name|Use|
|---|---|
|bloc|Implement BLoC pattern|
|flutter_bloc|Implement BLoC pattern|
|equatable|Implement BLoC pattern|
|rxdart|Implement BLoC pattern|
|http|Make request to PokeApi|
|cached_network_image|Show sprites|
|shared_preferences|Store the auth state|
|firebase_core|Implement Auth|
|firebase_auth|Implement Auth|


## Test

###Integration test

```
$ flutter drive --target=test_driver/app.dart
```

###Unit test

```
$ flutter test
```