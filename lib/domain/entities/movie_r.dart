import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie.dart';

class MovieR extends Equatable {
  final List<Movie>? results;

  const MovieR({
    this.results,
  });

  @override
  List<Object?> get props => [results];
}
