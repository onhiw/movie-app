part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {}

class FetchMovie extends MovieEvent {
  FetchMovie();

  @override
  List<Object?> get props => [];
}
