import 'dart:core';

import 'package:game_boy_graphics_editor/models/graphics/graphics.dart';

class MetaTile extends Graphics {
  MetaTile({data, required height, required width})
      : super(
            data: data ?? List.filled(width * height, 0, growable: true),
            width: width,
            height: height);

  copyWith({List<int>? data, int? width, int? height}) => MetaTile(
        data: data ?? [...this.data],
        width: width ?? this.width,
        height: height ?? this.height,
      );

  static int tileSize = 8;
  static int nbPixelPerTile = tileSize * tileSize;

  int get nbTilePerRow => (width ~/ tileSize);

  int get nbPixel => width * height;

  List<int> getTileAtIndex(int index) {
    return data.getRange(nbPixel * index, nbPixel * index + nbPixel).toList();
  }

  int getPixel(int rowIndex, int colIndex, int tileIndex) =>
      data[(colIndex * width + rowIndex) + nbPixel * tileIndex];

  void setPixel(int rowIndex, int colIndex, int tileIndex, int intensity) =>
      data[(colIndex * width + rowIndex) + nbPixel * tileIndex] = intensity;

  List<int> getRow(int tileIndex, int rowIndex) => data.sublist(
      tileIndex * nbPixel + rowIndex * width,
      tileIndex * nbPixel + rowIndex * height + width);

  void setRow(int tileIndex, int rowIndex, List<int> row) {
    for (int dotIndex = 0; dotIndex < width; dotIndex++) {
      setPixel(dotIndex, rowIndex, tileIndex, row[dotIndex]);
    }
  }

  flood(int metaTileIndex, int intensity, int rowIndex, int colIndex,
      int targetColor) {
    if (getPixel(rowIndex, colIndex, metaTileIndex) == targetColor) {
      setPixel(rowIndex, colIndex, metaTileIndex, intensity);
      if (inbound(rowIndex, colIndex - 1)) {
        flood(metaTileIndex, intensity, rowIndex, colIndex - 1, targetColor);
      }
      if (inbound(rowIndex, colIndex + 1)) {
        flood(metaTileIndex, intensity, rowIndex, colIndex + 1, targetColor);
      }
      if (inbound(rowIndex - 1, colIndex)) {
        flood(metaTileIndex, intensity, rowIndex - 1, colIndex, targetColor);
      }
      if (inbound(rowIndex + 1, colIndex)) {
        flood(metaTileIndex, intensity, rowIndex + 1, colIndex, targetColor);
      }
    }
  }

  inbound(int rowIndex, int colIndex) =>
      rowIndex >= 0 && rowIndex < height && colIndex >= 0 && colIndex < width;
}
