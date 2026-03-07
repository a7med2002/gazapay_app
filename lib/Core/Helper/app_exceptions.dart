class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException(message) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppExceptions {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}

class ConflictException extends AppExceptions {
  ConflictException([message]) : super(message, "Conflict: ");
}
