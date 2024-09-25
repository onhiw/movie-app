import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/utils/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieR>> getMovie();
  Future<Either<Failure, MovieVideoR>> getMovieVideo(String id);
  Future<Either<Failure, MovieR>> getMovieSearch(String query);
}
