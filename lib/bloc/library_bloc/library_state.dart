import 'package:equatable/equatable.dart';

abstract class LibraryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LibraryInitial extends LibraryState {}

class LibraryLoading extends LibraryState {
  final double progress;

  LibraryLoading({this.progress = 0.0});

  @override
  List<Object?> get props => [progress];
}

class LibrarySuccess extends LibraryState {
  final String message;

  LibrarySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LibraryError extends LibraryState {
  final String error;

  LibraryError(this.error);

  @override
  List<Object?> get props => [error];
}
