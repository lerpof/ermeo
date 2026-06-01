import 'package:flutter/foundation.dart';

/// Notifies [GoRouter] when in-memory auth session changes.
class SessionNotifier extends ChangeNotifier {
  void notifySessionChanged() => notifyListeners();
}
