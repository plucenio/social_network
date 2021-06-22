abstract class IFailure {
  final String message;

  IFailure(this.message);
}

class UnexpectedFailure implements IFailure {
  final String message;

  UnexpectedFailure(this.message);
}

class FirebaseAuthFailure implements IFailure {
  final String message;

  FirebaseAuthFailure(this.message);
}
