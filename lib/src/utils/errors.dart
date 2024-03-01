class UnnamedParameterError extends Error {
  final String message;

  UnnamedParameterError(this.message);

  @override
  String toString() {
    return 'UnnamedParameterError: $message';
  }
}

class BadArgumentsError extends Error {
  final String message;

  BadArgumentsError(this.message);

  @override
  String toString() {
    return 'BadArgumentsError: $message';
  }
}

class MissingArgumentError extends Error {
  final String message;

  MissingArgumentError(this.message);

  @override
  String toString() {
    return 'MissingArgumentError: $message';
  }
}
