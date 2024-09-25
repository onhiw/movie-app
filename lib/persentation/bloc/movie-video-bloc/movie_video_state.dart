part of 'movie_video_bloc.dart';

abstract class MovieVideoState extends Equatable {
  const MovieVideoState();
}

class MovieVideoInitial extends MovieVideoState {
  @override
  List<Object?> get props => [];
}

class MovieVideoLoading extends MovieVideoState {
  @override
  List<Object?> get props => [];
}

class MovieVideoLoaded extends MovieVideoState {
  final MovieVideoR movieVideoR;

  const MovieVideoLoaded(this.movieVideoR);

  @override
  List<Object?> get props => [movieVideoR];
}

class MovieVideoError extends MovieVideoState {
  final String message;

  const MovieVideoError(this.message);

  @override
  List<Object?> get props => [message];
}
