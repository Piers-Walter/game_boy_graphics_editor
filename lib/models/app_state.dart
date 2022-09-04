import 'dart:ui';

import 'colors.dart';

class AppState {
  int intensity;
  int tileIndexTile;
  int tileIndexBackground;
  bool tileMode; // edit tile or background
  bool showGridTile;
  bool floodMode;
  bool showGridBackground;
  List<int> tileBuffer; // copy / past tiles buffer
  List<Color> colorSet;
  String tileName;

  AppState({
    this.intensity = 3,
    this.tileIndexTile = 0,
    this.tileIndexBackground = 0,
    this.tileMode = true,
    this.showGridTile = true,
    this.tileName = "Tile",
    this.floodMode = false,
    this.showGridBackground = true,
    this.tileBuffer = const <int>[],
    this.colorSet = colorsDMG,
  });

  copyWith(
          {int? intensity,
          int? tileIndexTile,
          int? tileIndexBackground,
          bool? tileMode,
          bool? showGridTile,
          String? tileName,
          bool? floodMode,
          bool? showGridBackground,
          List<int>? tileBuffer,
          List<Color>? colorSet}) =>
      AppState(
        intensity: intensity ?? this.intensity,
        tileIndexTile: tileIndexTile ?? this.tileIndexTile,
        tileIndexBackground: tileIndexBackground ?? this.tileIndexBackground,
        tileMode: tileMode ?? this.tileMode,
        showGridTile: showGridTile ?? this.showGridTile,
        tileName: tileName ?? this.tileName,
        floodMode: floodMode ?? this.floodMode,
        showGridBackground: showGridBackground ?? this.showGridBackground,
        tileBuffer: tileBuffer ?? this.tileBuffer,
        colorSet: colorSet ?? this.colorSet,
      );
}
