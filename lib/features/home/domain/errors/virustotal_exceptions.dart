class VirusTotalException implements Exception {
  final String message;
  final int? statusCode;

  VirusTotalException(this.message, {this.statusCode});

  @override
  String toString() {
    if (statusCode != null) {
      return 'VirusTotalException: $message (Status Code: $statusCode)';
    }
    return 'VirusTotalException: $message';
  }
}

class NetworkException extends VirusTotalException {
  NetworkException(String message) : super('Network Error: $message');
}

class ServerException extends VirusTotalException {
  ServerException(String message, int statusCode)
    : super('Server Error: $message', statusCode: statusCode);
}

class UnauthorizedException extends VirusTotalException {
  UnauthorizedException(String message)
    : super('Unauthorized Error: $message', statusCode: 401);
}

class NotFoundException extends VirusTotalException {
  NotFoundException(String message)
    : super('Not Found Error: $message', statusCode: 404);
}

class BadRequestException extends VirusTotalException {
  BadRequestException(String message)
    : super('Bad Request Error: $message', statusCode: 400);
}

class UnknownException extends VirusTotalException {
  UnknownException(String message) : super('Unknown Error: $message');
}
