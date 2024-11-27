import 'package:dartz/dartz.dart';
import 'package:movie_app/data/datasources/movie_local_data_source.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_table.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/utils/exception.dart';
import 'package:movie_app/utils/failure.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(
      {required this.movieRemoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, MovieR>> getMovie(String type) async {
    try {
      final result = await movieRemoteDataSource.getMovie(type);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, MovieVideoR>> getMovieVideo(String id) async {
    try {
      final result = await movieRemoteDataSource.getMovieVideo(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, MovieR>> getMovieSearch(String query) async {
    try {
      final result = await movieRemoteDataSource.getMovieSearch(query);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    } on FormatException {
      return const Left(ServerFailure(
          'Oops, An error occurred while connecting to the server'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(Movie movie) async {
    try {
      final result =
          await localDataSource.insertWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(Movie movie) async {
    try {
      final result =
          await localDataSource.removeWatchlist(MovieTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchlistMovies() async {
    final result = await localDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
