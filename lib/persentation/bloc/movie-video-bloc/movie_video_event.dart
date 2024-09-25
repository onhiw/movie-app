part of 'movie_video_bloc.dart';

abstract class MovieVideoEvent extends Equatable {}

class FetchMovieVideo extends MovieVideoEvent {
  final String? id;

  FetchMovieVideo({this.id});

  @override
  List<Object?> get props => [id];
}
