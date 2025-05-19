import 'package:equatable/equatable.dart';

class Failure extends Equatable{
  final int statusCode;
  final String message;

  const Failure({required this.statusCode, required this.message});

  String get errorMessage=>"$statusCode: $message";
  @override
  List<Object?> get props=>[statusCode,message];
}