// Design token codegen for beneesse_ui.
//
// Reads design_tokens/tokens.json, resolves {references}, validates, and emits
// generated Dart files under lib/src/tokens/generated/.

import 'dart:convert';
import 'dart:io';

/// Thrown when token validation or reference resolution fails.
class TokenGenerationException implements Exception {
  TokenGenerationException(this.message);

  final String message;

  @override
  String toString() => 'TokenGenerationException: $message';
}

/// Parsed and validated design tokens ready for Dart emission.
class ParsedTokens {
  ParsedTokens({
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.shadows,
    required this.typography,
    required this.semanticLight,
    required this.semanticDark,
  });

  final Map<String, ColorValue> colors;
  final Map<String, double> spacing;
  final Map<String, double> radius;
  final Map<String, ShadowValue> shadows;
  final TypographyValue typography;
  final SemanticTheme semanticLight;
  final SemanticTheme semanticDark;
}

class ColorValue {
  ColorValue(this.hex);

  final String hex;

  int get argb {
    final hexValue = hex.replaceFirst('#', '');
    if (hexValue.length != 6 && hexValue.length != 8) {
      throw TokenGenerationException('Invalid hex color: $hex');
    }
    final value = int.parse(hexValue, radix: 16);
    if (hexValue.length == 6) {
      return 0xFF000000 | value;
    }
    return value;
  }
}

class ShadowValue {
  ShadowValue({
    required this.color,
    required this.alpha,
    required this.blur,
    required this.offsetX,
    required this.offsetY,
    required this.spread,
  });

  final ColorValue color;
  final double alpha;
  final double blur;
  final double offsetX;
  final double offsetY;
  final double spread;
}

class TextStyleValue {
  TextStyleValue({
    required this.size,
    required this.weight,
    required this.height,
    required this.letterSpacing,
  });

  final double size;
  final int weight;
  final double height;
  final double letterSpacing;
}

class TypographyValue {
  TypographyValue({
    required this.fontFamily,
    required this.styles,
  });

  final String fontFamily;
  final Map<String, TextStyleValue> styles;
}

class SemanticTheme {
  SemanticTheme({
    required this.colors,
    required this.shadows,
    required this.spacing,
    required this.radius,
  });

  final Map<String, ColorValue> colors;
  final Map<String, ShadowValue> shadows;
  final Map<String, double> spacing;
  final Map<String, double> radius;
}

/// Parses [json] map into validated [ParsedTokens].
ParsedTokens parseTokens(Map<String, dynamic> json) {
  final colors = _parseColors(json['color'] as Map<String, dynamic>? ?? {});
  final spacing = _parseDoubles(json['spacing'] as Map<String, dynamic>? ?? {});
  final radius = _parseDoubles(json['radius'] as Map<String, dynamic>? ?? {});
  final shadows = _parseShadows(
    json['shadow'] as Map<String, dynamic>? ?? {},
    colors,
  );
  final typography = _parseTypography(
    json['typography'] as Map<String, dynamic>? ?? {},
  );

  final semantic = json['semantic'] as Map<String, dynamic>? ?? {};
  final lightRaw = semantic['light'] as Map<String, dynamic>? ?? {};
  final darkRaw = semantic['dark'] as Map<String, dynamic>? ?? {};

  final semanticLight = _parseSemanticTheme(
    lightRaw,
    colors: colors,
    spacing: spacing,
    radius: radius,
    shadows: shadows,
    themeName: 'light',
  );
  final semanticDark = _parseSemanticTheme(
    darkRaw,
    colors: colors,
    spacing: spacing,
    radius: radius,
    shadows: shadows,
    themeName: 'dark',
  );

  _validateSemanticParity(semanticLight, semanticDark);

  return ParsedTokens(
    colors: colors,
    spacing: spacing,
    radius: radius,
    shadows: shadows,
    typography: typography,
    semanticLight: semanticLight,
    semanticDark: semanticDark,
  );
}

Map<String, ColorValue> _parseColors(Map<String, dynamic> raw) {
  final result = <String, ColorValue>{};
  raw.forEach((scale, steps) {
    if (steps is! Map) {
      throw TokenGenerationException('Color scale "$scale" must be a map');
    }
    steps.forEach((step, value) {
      final key = _colorKey(scale, step.toString());
      if (result.containsKey(key)) {
        throw TokenGenerationException('Duplicate color key: $key');
      }
      final hex = value.toString();
      _validateHex(hex);
      result[key] = ColorValue(hex);
    });
  });
  return result;
}

Map<String, double> _parseDoubles(Map<String, dynamic> raw) {
  final result = <String, double>{};
  raw.forEach((key, value) {
    if (result.containsKey(key)) {
      throw TokenGenerationException('Duplicate key: $key');
    }
    if (value is! num) {
      throw TokenGenerationException('Expected number for "$key", got $value');
    }
    result[key] = value.toDouble();
  });
  return result;
}

Map<String, ShadowValue> _parseShadows(
  Map<String, dynamic> raw,
  Map<String, ColorValue> colors,
) {
  final result = <String, ShadowValue>{};
  raw.forEach((name, value) {
    if (result.containsKey(name)) {
      throw TokenGenerationException('Duplicate shadow key: $name');
    }
    if (value is! Map) {
      throw TokenGenerationException('Shadow "$name" must be a map');
    }
    result[name] = _parseShadowDefinition(
      Map<String, dynamic>.from(value),
      colors,
      context: 'shadow.$name',
    );
  });
  return result;
}

ShadowValue _parseShadowDefinition(
  Map<String, dynamic> raw,
  Map<String, ColorValue> colors, {
  required String context,
}) {
  final colorRef = raw['color']?.toString();
  if (colorRef == null) {
    throw TokenGenerationException('Missing color in $context');
  }
  final color = _resolveColorRef(colorRef, colors);
  final alpha = _requireNum(raw['alpha'], '$context.alpha');
  final blur = _requireNum(raw['blur'], '$context.blur');
  final offsetX = _requireNum(raw['offsetX'], '$context.offsetX');
  final offsetY = _requireNum(raw['offsetY'], '$context.offsetY');
  final spread = _requireNum(raw['spread'], '$context.spread');
  return ShadowValue(
    color: color,
    alpha: alpha,
    blur: blur,
    offsetX: offsetX,
    offsetY: offsetY,
    spread: spread,
  );
}

TypographyValue _parseTypography(Map<String, dynamic> raw) {
  final fontFamily = raw['fontFamily']?.toString() ?? 'Roboto';
  final styles = <String, TextStyleValue>{};
  raw.forEach((key, value) {
    if (key == 'fontFamily') {
      return;
    }
    if (value is! Map) {
      throw TokenGenerationException('Typography "$key" must be a map');
    }
    if (styles.containsKey(key)) {
      throw TokenGenerationException('Duplicate typography key: $key');
    }
    styles[key] = TextStyleValue(
      size: _requireNum(value['size'], 'typography.$key.size'),
      weight: _requireNum(value['weight'], 'typography.$key.weight').toInt(),
      height: _requireNum(value['height'], 'typography.$key.height'),
      letterSpacing: _requireNum(
        value['letterSpacing'],
        'typography.$key.letterSpacing',
      ),
    );
  });
  return TypographyValue(fontFamily: fontFamily, styles: styles);
}

SemanticTheme _parseSemanticTheme(
  Map<String, dynamic> raw, {
  required Map<String, ColorValue> colors,
  required Map<String, double> spacing,
  required Map<String, double> radius,
  required Map<String, ShadowValue> shadows,
  required String themeName,
}) {
  final colorRaw = raw['color'] as Map<String, dynamic>? ?? {};
  final shadowRaw = raw['shadow'] as Map<String, dynamic>? ?? {};
  final spacingRaw = raw['spacing'] as Map<String, dynamic>? ?? {};
  final radiusRaw = raw['radius'] as Map<String, dynamic>? ?? {};

  final semanticColors = <String, ColorValue>{};
  colorRaw.forEach((name, ref) {
    if (semanticColors.containsKey(name)) {
      throw TokenGenerationException(
        'Duplicate semantic color in $themeName: $name',
      );
    }
    semanticColors[name] = _resolveColorRef(ref.toString(), colors);
  });

  final semanticShadows = <String, ShadowValue>{};
  shadowRaw.forEach((name, ref) {
    if (semanticShadows.containsKey(name)) {
      throw TokenGenerationException(
        'Duplicate semantic shadow in $themeName: $name',
      );
    }
    semanticShadows[name] = _resolveShadowRef(ref.toString(), shadows);
  });

  final semanticSpacing = <String, double>{};
  spacingRaw.forEach((name, ref) {
    if (semanticSpacing.containsKey(name)) {
      throw TokenGenerationException(
        'Duplicate semantic spacing in $themeName: $name',
      );
    }
    semanticSpacing[name] = _resolveSpacingRef(ref.toString(), spacing);
  });

  final semanticRadius = <String, double>{};
  radiusRaw.forEach((name, ref) {
    if (semanticRadius.containsKey(name)) {
      throw TokenGenerationException(
        'Duplicate semantic radius in $themeName: $name',
      );
    }
    semanticRadius[name] = _resolveRadiusRef(ref.toString(), radius);
  });

  return SemanticTheme(
    colors: semanticColors,
    shadows: semanticShadows,
    spacing: semanticSpacing,
    radius: semanticRadius,
  );
}

void _validateSemanticParity(SemanticTheme light, SemanticTheme dark) {
  _validateKeyParity('color', light.colors.keys, dark.colors.keys);
  _validateKeyParity('shadow', light.shadows.keys, dark.shadows.keys);
  _validateKeyParity('spacing', light.spacing.keys, dark.spacing.keys);
  _validateKeyParity('radius', light.radius.keys, dark.radius.keys);
}

void _validateKeyParity(String category, Iterable<String> light, Iterable<String> dark) {
  final lightSet = light.toSet();
  final darkSet = dark.toSet();
  final onlyLight = lightSet.difference(darkSet);
  final onlyDark = darkSet.difference(lightSet);
  if (onlyLight.isNotEmpty || onlyDark.isNotEmpty) {
    throw TokenGenerationException(
      'Semantic $category key mismatch between light and dark.\n'
      'Only in light: ${onlyLight.join(', ')}\n'
      'Only in dark: ${onlyDark.join(', ')}',
    );
  }
}

ColorValue _resolveColorRef(String ref, Map<String, ColorValue> colors) {
  final path = _parseRef(ref);
  if (path.length != 3 || path[0] != 'color') {
    throw TokenGenerationException('Invalid color reference: $ref');
  }
  final key = _colorKey(path[1], path[2]);
  final value = colors[key];
  if (value == null) {
    throw TokenGenerationException('Unresolved color reference: $ref');
  }
  return value;
}

ShadowValue _resolveShadowRef(String ref, Map<String, ShadowValue> shadows) {
  final path = _parseRef(ref);
  if (path.length != 2 || path[0] != 'shadow') {
    throw TokenGenerationException('Invalid shadow reference: $ref');
  }
  final value = shadows[path[1]];
  if (value == null) {
    throw TokenGenerationException('Unresolved shadow reference: $ref');
  }
  return value;
}

double _resolveSpacingRef(String ref, Map<String, double> spacing) {
  final path = _parseRef(ref);
  if (path.length != 2 || path[0] != 'spacing') {
    throw TokenGenerationException('Invalid spacing reference: $ref');
  }
  final value = spacing[path[1]];
  if (value == null) {
    throw TokenGenerationException('Unresolved spacing reference: $ref');
  }
  return value;
}

double _resolveRadiusRef(String ref, Map<String, double> radius) {
  final path = _parseRef(ref);
  if (path.length != 2 || path[0] != 'radius') {
    throw TokenGenerationException('Invalid radius reference: $ref');
  }
  final value = radius[path[1]];
  if (value == null) {
    throw TokenGenerationException('Unresolved radius reference: $ref');
  }
  return value;
}

List<String> _parseRef(String ref) {
  final match = RegExp(r'^\{(.+)\}$').firstMatch(ref.trim());
  if (match == null) {
    throw TokenGenerationException('Invalid reference syntax: $ref');
  }
  return match.group(1)!.split('.');
}

String _colorKey(String scale, String step) => '${scale}_$step';

void _validateHex(String hex) {
  if (!RegExp(r'^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$').hasMatch(hex)) {
    throw TokenGenerationException('Invalid hex color: $hex');
  }
}

double _requireNum(Object? value, String label) {
  if (value is! num) {
    throw TokenGenerationException('Expected number for $label, got $value');
  }
  return value.toDouble();
}

/// Generates Dart source for primitive tokens.
String generatePrimitiveTokensDart(ParsedTokens tokens) {
  final buffer = StringBuffer();
  buffer.writeln(_generatedHeader());
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln();
  buffer.writeln('/// Raw color scale values from the design system.');
  buffer.writeln('abstract final class BePrimitiveColors {');
  buffer.writeln('  BePrimitiveColors._();');

  final sortedColorKeys = tokens.colors.keys.toList()..sort();
  for (final key in sortedColorKeys) {
    final color = tokens.colors[key]!;
    buffer.writeln(
      '  static const $key = Color(0x${color.argb.toRadixString(16).padLeft(8, '0').toUpperCase()});',
    );
  }
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Raw spacing scale values.');
  buffer.writeln('abstract final class BePrimitiveSpacing {');
  buffer.writeln('  BePrimitiveSpacing._();');
  final sortedSpacingKeys = tokens.spacing.keys.toList()..sort();
  for (final key in sortedSpacingKeys) {
    buffer.writeln('  static const $key = ${tokens.spacing[key]};');
  }
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Raw border-radius scale values.');
  buffer.writeln('abstract final class BePrimitiveRadius {');
  buffer.writeln('  BePrimitiveRadius._();');
  final sortedRadiusKeys = tokens.radius.keys.toList()..sort();
  for (final key in sortedRadiusKeys) {
    buffer.writeln('  static const $key = ${tokens.radius[key]};');
  }
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Primitive shadow definition before semantic mapping.');
  buffer.writeln('class BePrimitiveShadowDefinition {');
  buffer.writeln('  const BePrimitiveShadowDefinition({');
  buffer.writeln('    required this.color,');
  buffer.writeln('    required this.alpha,');
  buffer.writeln('    required this.blur,');
  buffer.writeln('    required this.offsetX,');
  buffer.writeln('    required this.offsetY,');
  buffer.writeln('    required this.spread,');
  buffer.writeln('  });');
  buffer.writeln();
  buffer.writeln('  final Color color;');
  buffer.writeln('  final double alpha;');
  buffer.writeln('  final double blur;');
  buffer.writeln('  final double offsetX;');
  buffer.writeln('  final double offsetY;');
  buffer.writeln('  final double spread;');
  buffer.writeln();
  buffer.writeln('  List<BoxShadow> toBoxShadows() {');
  buffer.writeln('    return [');
  buffer.writeln('      BoxShadow(');
  buffer.writeln('        color: color.withValues(alpha: alpha),');
  buffer.writeln('        blurRadius: blur,');
  buffer.writeln('        offset: Offset(offsetX, offsetY),');
  buffer.writeln('        spreadRadius: spread,');
  buffer.writeln('      ),');
  buffer.writeln('    ];');
  buffer.writeln('  }');
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Raw shadow scale values.');
  buffer.writeln('abstract final class BePrimitiveShadows {');
  buffer.writeln('  BePrimitiveShadows._();');
  final sortedShadowKeys = tokens.shadows.keys.toList()..sort();
  for (final key in sortedShadowKeys) {
    final shadow = tokens.shadows[key]!;
    buffer.writeln('  static const $key = BePrimitiveShadowDefinition(');
    buffer.writeln(
      '    color: Color(0x${shadow.color.argb.toRadixString(16).padLeft(8, '0').toUpperCase()}),',
    );
    buffer.writeln('    alpha: ${shadow.alpha},');
    buffer.writeln('    blur: ${shadow.blur},');
    buffer.writeln('    offsetX: ${shadow.offsetX},');
    buffer.writeln('    offsetY: ${shadow.offsetY},');
    buffer.writeln('    spread: ${shadow.spread},');
    buffer.writeln('  );');
  }
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Primitive typography style definition.');
  buffer.writeln('class BePrimitiveTextStyleDefinition {');
  buffer.writeln('  const BePrimitiveTextStyleDefinition({');
  buffer.writeln('    required this.size,');
  buffer.writeln('    required this.weight,');
  buffer.writeln('    required this.height,');
  buffer.writeln('    required this.letterSpacing,');
  buffer.writeln('  });');
  buffer.writeln();
  buffer.writeln('  final double size;');
  buffer.writeln('  final FontWeight weight;');
  buffer.writeln('  final double height;');
  buffer.writeln('  final double letterSpacing;');
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Raw typography scale values.');
  buffer.writeln('abstract final class BePrimitiveTypography {');
  buffer.writeln('  BePrimitiveTypography._();');
  buffer.writeln(
    "  static const fontFamily = '${tokens.typography.fontFamily}';",
  );
  final sortedTypoKeys = tokens.typography.styles.keys.toList()..sort();
  for (final key in sortedTypoKeys) {
    final style = tokens.typography.styles[key]!;
    buffer.writeln('  static const $key = BePrimitiveTextStyleDefinition(');
    buffer.writeln('    size: ${style.size},');
    buffer.writeln('    weight: FontWeight.w${style.weight},');
    buffer.writeln('    height: ${style.height},');
    buffer.writeln('    letterSpacing: ${style.letterSpacing},');
    buffer.writeln('  );');
  }
  buffer.writeln('}');

  return buffer.toString();
}

/// Generates Dart source for resolved semantic token maps.
String generateSemanticTokenMapsDart(ParsedTokens tokens) {
  final buffer = StringBuffer();
  buffer.writeln(_generatedHeader());
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln();
  buffer.writeln("import 'primitive_tokens.g.dart';");
  buffer.writeln();
  buffer.writeln('/// Resolved semantic color maps per theme.');
  buffer.writeln('abstract final class BeSemanticColorMap {');
  _writeColorMap(buffer, 'light', tokens.semanticLight.colors);
  _writeColorMap(buffer, 'dark', tokens.semanticDark.colors);
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Resolved semantic shadow maps per theme.');
  buffer.writeln('abstract final class BeSemanticShadowMap {');
  _writeShadowMap(buffer, 'light', tokens.semanticLight.shadows);
  _writeShadowMap(buffer, 'dark', tokens.semanticDark.shadows);
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Resolved semantic spacing maps per theme.');
  buffer.writeln('abstract final class BeSemanticSpacingMap {');
  _writeDoubleMap(buffer, 'light', tokens.semanticLight.spacing);
  _writeDoubleMap(buffer, 'dark', tokens.semanticDark.spacing);
  buffer.writeln('}');
  buffer.writeln();

  buffer.writeln('/// Resolved semantic radius maps per theme.');
  buffer.writeln('abstract final class BeSemanticRadiusMap {');
  _writeDoubleMap(buffer, 'light', tokens.semanticLight.radius);
  _writeDoubleMap(buffer, 'dark', tokens.semanticDark.radius);
  buffer.writeln('}');

  return buffer.toString();
}

void _writeColorMap(
  StringBuffer buffer,
  String theme,
  Map<String, ColorValue> colors,
) {
  buffer.writeln('  static const $theme = <String, Color>{');
  final sortedKeys = colors.keys.toList()..sort();
  for (final key in sortedKeys) {
    final color = colors[key]!;
    buffer.writeln(
      "    '$key': Color(0x${color.argb.toRadixString(16).padLeft(8, '0').toUpperCase()}),",
    );
  }
  buffer.writeln('  };');
}

void _writeShadowMap(
  StringBuffer buffer,
  String theme,
  Map<String, ShadowValue> shadows,
) {
  buffer.writeln('  static const $theme = <String, BePrimitiveShadowDefinition>{');
  final sortedKeys = shadows.keys.toList()..sort();
  for (final key in sortedKeys) {
    final shadow = shadows[key]!;
    buffer.writeln("    '$key': BePrimitiveShadowDefinition(");
    buffer.writeln(
      '      color: Color(0x${shadow.color.argb.toRadixString(16).padLeft(8, '0').toUpperCase()}),',
    );
    buffer.writeln('      alpha: ${shadow.alpha},');
    buffer.writeln('      blur: ${shadow.blur},');
    buffer.writeln('      offsetX: ${shadow.offsetX},');
    buffer.writeln('      offsetY: ${shadow.offsetY},');
    buffer.writeln('      spread: ${shadow.spread},');
    buffer.writeln('    ),');
  }
  buffer.writeln('  };');
}

void _writeDoubleMap(
  StringBuffer buffer,
  String theme,
  Map<String, double> values,
) {
  buffer.writeln('  static const $theme = <String, double>{');
  final sortedKeys = values.keys.toList()..sort();
  for (final key in sortedKeys) {
    buffer.writeln("    '$key': ${values[key]},");
  }
  buffer.writeln('  };');
}

String _generatedHeader() => '''
// GENERATED CODE - DO NOT MODIFY BY HAND
//
// Run `melos run generate:tokens` to regenerate.
''';

/// Reads tokens from [inputPath], validates, and writes generated Dart files.
void generateTokenFiles({
  required String inputPath,
  required String outputDirectory,
}) {
  final inputFile = File(inputPath);
  if (!inputFile.existsSync()) {
    throw TokenGenerationException('Token file not found: $inputPath');
  }

  final json = jsonDecode(inputFile.readAsStringSync()) as Map<String, dynamic>;
  final tokens = parseTokens(json);

  final outputDir = Directory(outputDirectory);
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  File('$outputDirectory/primitive_tokens.g.dart').writeAsStringSync(
    generatePrimitiveTokensDart(tokens),
  );
  File('$outputDirectory/semantic_token_maps.g.dart').writeAsStringSync(
    generateSemanticTokenMapsDart(tokens),
  );
}

void main(List<String> args) {
  final packageRoot = Directory.current.path;
  final inputPath = args.isNotEmpty
      ? args.first
      : '$packageRoot/design_tokens/tokens.json';
  final outputDirectory = args.length > 1
      ? args[1]
      : '$packageRoot/lib/src/tokens/generated';

  try {
    generateTokenFiles(inputPath: inputPath, outputDirectory: outputDirectory);
    stdout.writeln('Generated design tokens in $outputDirectory');
  } on TokenGenerationException catch (error) {
    stderr.writeln(error);
    exitCode = 1;
  }
}
