import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final int statusCode;
  final String message;

  const ApiException({required this.statusCode, required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [statusCode,message];
}