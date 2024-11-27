part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {}

class GetListMovieWatchlist extends MovieWatchlistEvent {
  @override
  List<Object> get props => [];
}

class GetListMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  GetListMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class MovieWatchlistAdd extends MovieWatchlistEvent {
  final Movie movie;

  MovieWatchlistAdd(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieWatchlistRemove extends MovieWatchlistEvent {
  final Movie movie;

  MovieWatchlistRemove(this.movie);

  @override
  List<Object> get props => [movie];
}
