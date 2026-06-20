enum AppEnvironment {
  dev,
  staging,
  prod;

  static AppEnvironment fromDefine(String value) {
    return AppEnvironment.values.firstWhere(
      (environment) => environment.name == value,
      orElse: () => AppEnvironment.dev,
    );
  }
}
