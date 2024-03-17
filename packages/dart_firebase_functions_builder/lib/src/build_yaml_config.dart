class BuildYamlConfig {
  /// Creates a new instance of [BuildYamlConfig] with specified configuration
  /// values.
  BuildYamlConfig._({
    required this.generateServicesJson,
    required this.servicesJsonPath,
  });

  /// Constructs a [BuildYamlConfig] from JSON configuration in `build.yaml`.
  ///
  /// Parses configuration options defined in `build.yaml` and creates an
  /// instance of [BuildYamlConfig] to be used in code generation.
  factory BuildYamlConfig.fromBuildYaml(Map<String, dynamic> json) =>
      BuildYamlConfig._(
        generateServicesJson: json['generate_services_json'] as bool? ?? true,
        servicesJsonPath:
            json['services_json_path'] as String? ?? './services.json',
      );

  final bool generateServicesJson;

  final String servicesJsonPath;
}
