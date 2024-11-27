import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/utils/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieR>> getMovie(String type);
  Future<Either<Failure, MovieVideoR>> getMovieVideo(String id);
  Future<Either<Failure, MovieR>> getMovieSearch(String query);
  Future<Either<Failure, String>> saveWatchlist(Movie movie);
  Future<Either<Failure, String>> removeWatchlist(Movie movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
