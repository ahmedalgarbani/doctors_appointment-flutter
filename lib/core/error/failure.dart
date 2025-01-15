abstract class Failure {
  final String message;

  Failure({required this.message});
}

class SqlFailure extends Failure {
  SqlFailure({required String message}) : super(message: message);
}
