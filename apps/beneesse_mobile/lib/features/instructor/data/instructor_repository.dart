import 'package:beneesse_api/beneesse_api.dart' hide InstructorSummary;

import '../../../core/di/service_locator.dart';
import '../models/instructor_summary.dart';
import 'instructor_converter.dart';

abstract class InstructorRepository {
  Future<List<InstructorSummary>> listInstructors();
}

class InstructorRepositoryImpl implements InstructorRepository {
  InstructorRepositoryImpl({
    BeneesseApiClient? apiClient,
    InstructorConverter? converter,
  })  : _api = apiClient ?? ServiceLocator.instance.apiClient,
        _converter = converter ?? const InstructorConverter();

  final BeneesseApiClient _api;
  final InstructorConverter _converter;

  @override
  Future<List<InstructorSummary>> listInstructors() async {
    final response = await _api.run(
      () => _api.instructors.listInstructors().then((r) => r.data!),
    );
    return response.items.map(_converter.toSummary).toList();
  }
}
