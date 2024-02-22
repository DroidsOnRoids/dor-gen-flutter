class UnnamedParameterError extends Error {
  final String message;

  UnnamedParameterError(this.message);

  @override
  String toString() {
    return 'UnnamedParameterError: $message';
  }
}
