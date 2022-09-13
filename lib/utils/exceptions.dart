class APIExceptions implements Exception {
  String? msg;
  APIExceptions({required this.msg});

  @override
  String toString() => msg ?? super.toString();
}
