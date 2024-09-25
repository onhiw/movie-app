import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_video.dart';

class MovieVideoR extends Equatable {
  final int? id;
  final List<MovieVideo>? results;

  const MovieVideoR({
    this.id,
    this.results,
  });

  @override
  List<Object?> get props => [
        id,
        results,
      ];
}
