import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/generate_tokens.dart';

void main() {
  group('parseTokens', () {
    test('parses valid fixture and resolves references', () {
      final tokens = parseTokens(_createValidFixture());

      expect(tokens.colors['white_0']!.hex, '#FFFFFF');
      expect(tokens.spacing['md'], 16);
      expect(tokens.radius['lg'], 12);
      expect(tokens.shadows['elevation1']!.alpha, 0.05);
      expect(
        tokens.semanticLight.colors['backgroundPrimary']!.hex,
        '#FFFFFF',
      );
      expect(
        tokens.semanticDark.colors['backgroundPrimary']!.hex,
        '#111827',
      );
      expect(tokens.semanticLight.spacing['pagePadding'], 16);
      expect(tokens.semanticLight.radius['card'], 12);
    });

    test('throws on invalid hex color', () {
      final fixture = _createValidFixture();
      fixture['color'] = {
        'white': {'0': 'not-a-color'},
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws on unresolved color reference', () {
      final fixture = _createValidFixture();
      (fixture['semantic'] as Map<String, dynamic>)['light'] = {
        'color': {'backgroundPrimary': '{color.missing.0}'},
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws on invalid reference syntax', () {
      final fixture = _createValidFixture();
      (fixture['semantic'] as Map<String, dynamic>)['light'] = {
        'color': {'backgroundPrimary': 'color.white.0'},
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws when light and dark semantic keys differ', () {
      final fixture = _createValidFixture();
      (fixture['semantic'] as Map<String, dynamic>)['dark'] = {
        'color': {'backgroundPrimary': '{color.neutral.900}'},
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws on duplicate primitive color keys', () {
      final fixture = _createValidFixture();
      fixture['color'] = {
        'white': {'0': '#FFFFFF', '50': '#FAFAFA'},
        'duplicate': {'0': '#111111'},
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws on non-numeric spacing value', () {
      final fixture = _createValidFixture();
      fixture['spacing'] = {'md': 'sixteen'};

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });

    test('throws when shadow color reference is missing', () {
      final fixture = _createValidFixture();
      fixture['shadow'] = {
        'elevation1': {
          'alpha': 0.1,
          'blur': 2,
          'offsetX': 0,
          'offsetY': 1,
          'spread': 0,
        },
      };

      expect(
        () => parseTokens(fixture),
        throwsA(isA<TokenGenerationException>()),
      );
    });
  });

  group('generateTokenFiles', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('be_tokens_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('writes generated dart files from json input', () {
      final inputPath = '${tempDir.path}/tokens.json';
      final outputPath = '${tempDir.path}/generated';
      File(inputPath).writeAsStringSync(jsonEncode(_createValidFixture()));

      generateTokenFiles(inputPath: inputPath, outputDirectory: outputPath);

      final primitiveFile = File('$outputPath/primitive_tokens.g.dart');
      final semanticFile = File('$outputPath/semantic_token_maps.g.dart');

      expect(primitiveFile.existsSync(), isTrue);
      expect(semanticFile.existsSync(), isTrue);
      expect(
        primitiveFile.readAsStringSync(),
        contains('abstract final class ErPrimitiveColors'),
      );
      expect(
        semanticFile.readAsStringSync(),
        contains('abstract final class ErSemanticColorMap'),
      );
    });

    test('throws when input file is missing', () {
      expect(
        () => generateTokenFiles(
          inputPath: '${tempDir.path}/missing.json',
          outputDirectory: '${tempDir.path}/out',
        ),
        throwsA(isA<TokenGenerationException>()),
      );
    });
  });

  group('generatePrimitiveTokensDart', () {
    test('includes color and typography definitions', () {
      final output = generatePrimitiveTokensDart(parseTokens(_createValidFixture()));

      expect(output, contains('static const white_0 = Color(0xFFFFFFFF);'));
      expect(output, contains('static const fontFamily = \'Inter\';'));
      expect(output, contains('toBoxShadows()'));
    });
  });

  group('generateSemanticTokenMapsDart', () {
    test('includes resolved semantic maps for both themes', () {
      final output = generateSemanticTokenMapsDart(parseTokens(_createValidFixture()));

      expect(output, contains("static const light = <String, Color>{"));
      expect(output, contains("static const dark = <String, Color>{"));
      expect(output, contains("'backgroundPrimary': Color(0xFFFFFFFF)"));
      expect(output, contains("'backgroundPrimary': Color(0xFF111827)"));
    });
  });

  group('ColorValue', () {
    test('parses 6-digit hex with full alpha', () {
      expect(ColorValue('#FFFFFF').argb, 0xFFFFFFFF);
    });

    test('parses 8-digit hex', () {
      expect(ColorValue('#80FFFFFF').argb, 0x80FFFFFF);
    });

    test('throws on invalid hex length', () {
      expect(
        () => ColorValue('#FFF').argb,
        throwsA(isA<TokenGenerationException>()),
      );
    });
  });
}

Map<String, dynamic> _createValidFixture() => {
  'color': {
    'white': {'0': '#FFFFFF', '50': '#FAFAFA'},
    'neutral': {'900': '#111827'},
    'brand': {'500': '#3B82F6'},
  },
  'spacing': {'md': 16, 'lg': 24},
  'radius': {'md': 8, 'lg': 12},
  'shadow': {
    'elevation1': {
      'color': '{color.neutral.900}',
      'alpha': 0.05,
      'blur': 2,
      'offsetX': 0,
      'offsetY': 1,
      'spread': 0,
    },
  },
  'typography': {
    'fontFamily': 'Inter',
    'bodyLarge': {
      'size': 16,
      'weight': 400,
      'height': 1.5,
      'letterSpacing': 0.5,
    },
  },
  'semantic': {
    'light': {
      'color': {
        'backgroundPrimary': '{color.white.0}',
        'textPrimary': '{color.neutral.900}',
        'brandPrimary': '{color.brand.500}',
      },
      'shadow': {'card': '{shadow.elevation1}'},
      'spacing': {'pagePadding': '{spacing.md}'},
      'radius': {'card': '{radius.lg}'},
    },
    'dark': {
      'color': {
        'backgroundPrimary': '{color.neutral.900}',
        'textPrimary': '{color.white.0}',
        'brandPrimary': '{color.brand.500}',
      },
      'shadow': {'card': '{shadow.elevation1}'},
      'spacing': {'pagePadding': '{spacing.md}'},
      'radius': {'card': '{radius.lg}'},
    },
  },
};
