// ignore_for_file: constant_identifier_names
class DorConfig {
  final bool generateUseCase;
  final bool generateDataSourceMethod;
  final ApiMethod? apiMethod;
  final String? path;

  const DorConfig({
    this.generateUseCase = true,
    this.generateDataSourceMethod = true,
    this.apiMethod,
    this.path,
  });
}

enum ApiMethod {
  GET,
  POST,
  PUT,
  DELETE,
}
