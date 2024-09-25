part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {}

class FetchMovieSearch extends MovieSearchEvent {
  final String? query;

  FetchMovieSearch({this.query});

  @override
  List<Object?> get props => [query];
}
