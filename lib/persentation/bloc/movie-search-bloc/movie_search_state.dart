part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
}

class MovieSearchInitial extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class MovieSearchLoading extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class MovieSearchLoaded extends MovieSearchState {
  final MovieR movieR;

  const MovieSearchLoaded(this.movieR);

  @override
  List<Object?> get props => [movieR];
}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
