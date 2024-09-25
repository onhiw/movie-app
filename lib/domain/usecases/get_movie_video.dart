import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

class GetMovieVideo {
  final MovieRepository movieRepository;

  GetMovieVideo(this.movieRepository);

  Future<Either<Failure, MovieVideoR>> execute(String id) {
    return movieRepository.getMovieVideo(id);
  }
}
