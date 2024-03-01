<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
1. [`Opis`](#opis)
1. [`Instalacja`](#instalacja)
1. [`Użycie`](#użycie)
1. [`Błędy`](#błędy)
1. [`Ograniczenia`](#ograniczenia)
1. [`Zgłaszanie błędów`](#zgłaszanie-błędów)
1. [`Roadmap`](ROADMAP.md)

# Dor Generator

Narzędzie do generowania kodu warstw domain i data.

## Opis

### Dto i mappery
Aby wygenerować klasę Dto dodaj adnotację [`Dto`] na klasie domain.
Możesz podać argumenty do [`Dto`] aby zmienić ustawienia generowanego kodu.
Możesz również zmienić ustawienia poszczególnych pól używając adnotacji [`DtoConfigure`]
Wygenerowana klasa będzie miała nazwę __\<nazwaKlasyŹródłowej\>Dto__ oraz wygenerowane zostaną extension na  __\<nazwaKlasyŹródłowejDto\>__ i __\<nazwaKlasyŹródłowej\>__ z metodami odpowiednio toDomain i toDto.
klasa __\<nazwaKlasyŹródłowej\>Dto__ będzie adnotowana adnotacją [`JsonSerializable`] którą można przekazać jako argument do [`Dto`].
Pola klasy __\<nazwaKlasyŹródłowej\>Dto__ będą adnotowane adnotacją [`JsonKey`] jeżeli zostanie ona podana jako argument do [`DtoConfig`].

### UseCase

Aby wygenerować klasy useCase do metod danej klasy dodaj do niej adnotacje [`DorGenerator`].
Możesz podać argumenty do [`DorGenerator`] aby zmienić ustawienia generowanego pliku.
Możesz również zmienić ustawienia poszczególnych metod używając [`DorConfigure`].
Wygenerowane klasy będą miały nazwy __\<nazwaMetody\>UseCase__ i będą adnotowane [`injectable`].
Aby można było wygenerować useCase wszystkie argumenty metody muszą być argumentami 'named'.

### Implementacja klasy abstrakcyjnej 
Aby wygenerować klasę Implementującą, dodaj adnotacje [`DorGenerator`].
Możesz podać argumenty do [`DorGenerator`] aby zmienić ustawienia generowanego pliku.
Możesz również zmienić ustawienia poszczególnych metod używając [`DorConfigure`].
Wygenerowana klasa będzie miała nazwę __\<nazwaKlasyŹródłowej\>Impl__ oraz adnotacje ```@LazySingleton(as: <nazwaKlasyŹródłowej> )```
Aby można było wygenerować metody wszystkie ich argumenty muszą być argumentami 'named'.
Klasa __\<nazwaKlasyŹródłowej\>Impl__ jako argument konstruktora przyjmuje klasę __\<nazwaKlasyŹródłowej\>DataSource__ którą importuje z pliku w tym samym katalogu co klasa źródłowa o nazwie __\<nazwaPlikuKlasyŹródłowej\>.data_source.g.dart__ 

### DataSource
Aby wygenerować klasę DataSource, dodaj adnotacje [`DorGenerator`].
Możesz podać argumenty do [`DorGenerator`] aby zmienić ustawienia generowanego pliku.
Możesz również zmienić ustawienia poszczególnych metod używając [`DorConfigure`].
Argumenty [`ApiMethod`] oraz `path` są obowiązkowe.
Wygenerowana klasa będzie klasą abstrakcyjną o nazwie __\<nazwaKlasyŹródłowej\>DataSource__ przygotowaną do tego aby z niej generować pliki przy użyciu paczki [`retrofit`] i jest adnotowana `@LazySingleton()` z paczki [`injectable`].
Argumenty metod można adnotować adnotacjami __Path__, __Body__ i __Query__ pochodzącymi z paczki retrofit.

## Instalacja
- Upewnij się że masz dodane do projektu paczki [`json_serializable`], [`json_annotation`], [`retrofit`] oraz [`injectable`].
- dodaj w pubspec.yaml 

```yaml
dependencies:  
  # dodaj dor_gen do swoich dependencies
  dor_gen:
    git:
      #TODO dodaj link do projektu
      url:
      # numer wersji
      ref: 0.5.0
```

## Użycie

### Dto

Dodaj adnotacje do swojej klasy
```dart
// Dodaj adnotacje dto
@Dto()
class Cat {
  final int id;
  final String name;
  final List<String> toys;

  const Cat({
    required this.id,
    required this.name,
    required this.toys,
  });
}
```
Uruchom generator

```sh
# dart
dart pub run build_runner build

# flutter
flutter pub run build_runner build
```
Powinien wygenerować się plik __\<nazwa_pliku_źródłowego\>.dto.g.dart__ 
z klasą CatDto oraz extension CatDtoToCat i CatToCatDto, oraz plik __\<nazwa_pliku_źródłowego\>.dto.g.g.dart__ wygenerowany przez json_serializable. 

### Klasy UseCase, Impl, DataSource
#### Standard
Dodaj adnotacje do klasy
```dart
//dodaj adnotacje DorGenerator do klasy
@DorGenerator()
abstract class FooRepository {
  //Dodaj adnotacje DorConfig do metod
  @DorConfig(
    apiMethod: ApiMethod.POST,
    path: '/api/v1/foo/doNothing',
  )
  Future<Thing> doSomething({
    required String id, 
    required String name,
  });
}
```

Uruchom generator

```sh
# dart
dart pub run build_runner build

# flutter
flutter pub run build_runner build
```

Powinny wygenerować się pliki:
- __\<nazwa_pliku_źródłowego\>.data_source.g.dart__ z abstrakcją klasy FooRepositoryDataSource
- __\<nazwa_pliku_źródłowego\>.data_source.g.g.dart__ wygenerowany przez retrofit
- __\<nazwa_pliku_źródłowego\>.use_case.g.dart__ z klasą DoSomethingUseCase
- __\<nazwa_pliku_źródłowego\>.impl.g.dart__ z klasą FooRepositoryImpl z implementacją FooRepository


#### Konfiguracja
- Jeżeli nie chcesz aby generował się któryś z tych elementów ustaw na __false__ odpowiedni argument:
  - __generateUseCase__ dla use_case
  - __generateDataSource__ dla data_source
  - __generateRepositoryImpl__ dla impl
- Jeżeli nie chcesz generować useCase dla konkretnej metody użyj znacznika adnotacji __DorConfig__ z parametrem __generateUseCase__ ustawionym na __false__.
- Jeżeli nie chcesz generować takiej metody w pliku dataSource użyj adnotacji __DorConfig__ z parametrem __generateDataSourceMethod__ ustawionym na __false__.

## Błędy
```UnnamedParameterError``` oznaczający, że któryś z argumentów w funkcjach lub konstruktorze nie jest 'named'.
```BadArgumentsError``` oznacza, że któryś argument został źle zastosowany.
```MissingArgumentError``` oznacza, że któryś z wymaganych argumentów w adnotacjach nie został podany.

## Ograniczenia
- nieobsługiwane argumenty w JsonSerializable:
  - converters
- nieobsługiwane argumenty w JsonKey:
  - defaultValue obsługuje tylko typy
    - null
    - bool
    - int
    - string
    - double
    - type
- w funkcjach wszystkie argumenty muszą być named
- jedyny typ po którym można iterować i jest obsługiwany to lista (nie obsługuje map, set itp)
- mogą pojawić się problemy gdy nasz typ jest parametryzowany - funkcjonalność nie jest przetestowana

## Zgłaszanie błędów
Paczka jest we wczesnej fazie dlatego proszę raportować wszystkie błędy i pomysły na udoskonalenia i nowe ficzerki za pomocą githuba [`link`](https://github.com/DroidsOnRoids/dor-gen-flutter/issues)

## Roadmap
Link do pliku roadmap [`link`](ROADMAP.md)


[`JsonSerializable`]: https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonSerializable-class.html
[`JsonKey`]: https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonKey-class.html
[`injectable`]: https://pub.dev/documentation/injectable/latest/
[`retrofit`]: https://pub.dev/packages/retrofit
[`json_serializable`]: https://pub.dev/packages/json_serializable
[`json_annotation`]: https://pub.dev/packages/json_annotation