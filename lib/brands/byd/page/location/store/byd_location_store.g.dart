// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'byd_location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BYDLocationStore on _BYDLocationStore, Store {
  final _$keyWordToSearchAtom = Atom(name: '_BYDLocationStore.keyWordToSearch');

  @override
  String get keyWordToSearch {
    _$keyWordToSearchAtom.reportRead();
    return super.keyWordToSearch;
  }

  @override
  set keyWordToSearch(String value) {
    _$keyWordToSearchAtom.reportWrite(value, super.keyWordToSearch, () {
      super.keyWordToSearch = value;
    });
  }

  final _$nearPoisAtom = Atom(name: '_BYDLocationStore.nearPois');

  @override
  List<Poi> get nearPois {
    _$nearPoisAtom.reportRead();
    return super.nearPois;
  }

  @override
  set nearPois(List<Poi> value) {
    _$nearPoisAtom.reportWrite(value, super.nearPois, () {
      super.nearPois = value;
    });
  }

  final _$shouldShowSinglePOIAtom =
      Atom(name: '_BYDLocationStore.shouldShowSinglePOI');

  @override
  bool get shouldShowSinglePOI {
    _$shouldShowSinglePOIAtom.reportRead();
    return super.shouldShowSinglePOI;
  }

  @override
  set shouldShowSinglePOI(bool value) {
    _$shouldShowSinglePOIAtom.reportWrite(value, super.shouldShowSinglePOI, () {
      super.shouldShowSinglePOI = value;
    });
  }

  @override
  String toString() {
    return '''
keyWordToSearch: ${keyWordToSearch},
nearPois: ${nearPois},
shouldShowSinglePOI: ${shouldShowSinglePOI}
    ''';
  }
}
