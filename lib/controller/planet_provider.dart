import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/planet_model.dart';

class PlanetProvider extends ChangeNotifier {
  List<PlanetModel> planetData = [];
  int _currentPlanetIndex = 0;
  bool isPlanetOpened = false;
  bool textAnimation = false;
  bool showText = false;
  int get currentPlanetIndex => _currentPlanetIndex;
  PlanetModel get currentPlanet => planetData[_currentPlanetIndex];
  Future<void> loadData() async {
    final json = await rootBundle.loadString("assets/json/planet.json");
    List jsonData = jsonDecode(json);
    planetData = jsonData.map((e) => PlanetModel.fromJson(e)).toList();

    notifyListeners();
  }

  void nextPlanet() {
    _currentPlanetIndex = (_currentPlanetIndex + 1) % planetData.length;
    notifyListeners();
  }

  Future<void> updatePlanetOpened(bool value) async {
    isPlanetOpened = value;
    notifyListeners();
    if (isPlanetOpened) {
      await Future.delayed(Duration(milliseconds: 700));
      showText = true;
      notifyListeners();
    } else {
      showText = false;
      notifyListeners();
    }
  }

  Future<void> startTextAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    textAnimation = true;
    notifyListeners();
  }

  void removeTextAnimation() {
    textAnimation = false;
    notifyListeners();
  }

  PlanetProvider() {
    print("calling");

    loadData();
    print("called");
  }
}
