import 'package:game_boy_graphics_editor/models/graphics/background.dart';
import 'package:game_boy_graphics_editor/models/sourceConverters/source_converter.dart';

import '../graphics/graphics.dart';

class GBDKBackgroundConverter extends SourceConverter {
  static final GBDKBackgroundConverter _singleton =
      GBDKBackgroundConverter._internal();

  factory GBDKBackgroundConverter() {
    return _singleton;
  }

  GBDKBackgroundConverter._internal();

  @override
  String toHeader(Graphics graphics, String name) {
    Background background = graphics as Background;

    return """ // AUTOGENERATED FILE FROM game_boy_graphics_editor
#ifndef MAP_${name}_H
#define MAP_${name}_H
#define ${name}_TILE_ORIGIN ${background.origin}
#define ${name}_WIDTH ${graphics.width}
#define ${name}_HEIGHT ${graphics.height}


extern const unsigned char $name[];

#endif
""";
  }

  @override
  String toSource(Graphics graphics, String name) =>
      """#define ${name}Width ${graphics.width}
const unsigned char $name[] = {${formatOutput(graphics.data.map((e) => decimalToHex(e, prefix: true)).toList())}};""";

  List fromSource(String source) {
    var background = Background();

    var graphicElement = readGraphicElementsFromSource(source)[0];
    background.data = graphicElement.values;

    RegExp regExpWidth = RegExp(r"#define \w+Width (\d+)");
    var matchesWidth = regExpWidth.allMatches(source);
    for (Match match in matchesWidth) {
      background.width = int.parse(match.group(1)!);
    }

    RegExp regExpHeight = RegExp(r"#define \w+Height (\d+)");
    var matchesHeight = regExpHeight.allMatches(source);
    for (Match match in matchesHeight) {
      background.height = int.parse(match.group(1)!);
    }
    return [graphicElement.name, background];
  }

  Background fromGraphicElement(GraphicElement graphicElement) =>
      Background(data: graphicElement.values);
}
