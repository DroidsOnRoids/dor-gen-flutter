class FieldDto {
  final String name;
  final List<FieldDto> parameters;

  FieldDto({
    required this.name,
    required this.parameters,
  });

  String toTypeString() {
    String result = '';
    if (parameters.isEmpty) {
      result = name;
    } else {
      result += '$name<';
      for (var parameter in parameters) {
        result += _recursiveString(parameter);
      }
      result += '>';
    }
    return result;
  }

  String _recursiveString(FieldDto fieldDto) {
    String typeName = '';
    if (fieldDto.parameters.isEmpty) {
      typeName += fieldDto.name;
    } else {
      typeName += '${fieldDto.name}<';
      for (var parameter in fieldDto.parameters) {
        typeName += _recursiveString(parameter);
      }
      typeName += '>';
    }
    return typeName;
  }

  @override
  String toString() {
    return 'FieldDto{name: $name, parameters: $parameters}';
  }
}
