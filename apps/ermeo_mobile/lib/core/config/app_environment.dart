/// Compile-time application environment from `APP_ENV` dart-define.
enum AppEnvironment {
  dev,
  prod;

  static AppEnvironment fromDefine(String value) {
    return switch (value) {
      'prod' => AppEnvironment.prod,
      'dev' => AppEnvironment.dev,
      _ => AppEnvironment.dev,
    };
  }
}
