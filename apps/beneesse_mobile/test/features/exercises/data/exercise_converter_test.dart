import 'package:beneesse_api/beneesse_api.dart';
import 'package:beneesse_mobile/features/exercises/data/exercise_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExerciseConverter', () {
    test('maps API exercise to summary', () {
      const converter = ExerciseConverter();
      final exercise = Exercise(
        id: '0001',
        name: 'Bench Press',
        bodyPart: 'chest',
        equipment: 'barbell',
        target: 'pectorals',
      );

      final summary = converter.toSummary(exercise);

      expect(summary.id, '0001');
      expect(summary.name, 'Bench Press');
      expect(summary.bodyPart, 'chest');
      expect(summary.equipment, 'barbell');
      expect(summary.target, 'pectorals');
    });
  });
}
