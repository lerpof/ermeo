import 'package:beneesse_api/beneesse_api.dart' as api;

import '../models/instructor_summary.dart';

class InstructorConverter {
  const InstructorConverter();

  InstructorSummary toSummary(api.InstructorSummary instructor) {
    return InstructorSummary(
      id: instructor.id,
      displayName: instructor.displayName,
      bio: instructor.bio,
    );
  }
}
