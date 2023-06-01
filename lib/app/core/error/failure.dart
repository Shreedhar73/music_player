import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

//General Failures
class ServerFailure extends Failure {
  final String? errorMsg;
  ServerFailure({this.errorMsg});
}

class CacheFailure extends Failure {}

class RealmFailure extends Failure {
  final String? errorMsg;
  RealmFailure({this.errorMsg});
}

//text field failures
class EmptyFieldFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class WrongAPiKeyException extends Failure {
  final String message;
  WrongAPiKeyException(this.message);
}
