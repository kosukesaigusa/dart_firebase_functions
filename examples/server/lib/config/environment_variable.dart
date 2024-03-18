import 'dart:io';

class EnvironmentProvider {
  String getEnvironmentVariable(String key) {
    final value = Platform.environment[key];
    if (value == null) {
      throw ArgumentError('Environment variable $key is not set');
    }
    return value;
  }
}

class EnvironmentVariable {
  EnvironmentVariable(this._provider);

  final EnvironmentProvider _provider;

  Environment get environment =>
      Environment.from(_provider.getEnvironmentVariable('ENVIRONMENT'));

  String get projectId => _provider.getEnvironmentVariable('PROJECT_ID');

  String get clientId => _provider.getEnvironmentVariable('CLIENT_ID');

  String get clientEmail => _provider.getEnvironmentVariable('CLIENT_EMAIL');

  String get privateKey => _provider.getEnvironmentVariable('PRIVATE_KEY');

  String get lineChannelId =>
      _provider.getEnvironmentVariable('LINE_CHANNEL_ID');
}

enum Environment {
  local,
  production,
  ;

  factory Environment.from(String? string) {
    return switch (string) {
      'local' => Environment.local,
      'production' => Environment.production,
      _ => throw ArgumentError('$string is not a valid environment'),
    };
  }
}
