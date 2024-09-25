import 'package:dartz/dartz.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/utils/exception.dart';
import 'package:movie_app/utils/failure.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl({required this.movieRemoteDataSource});

  @override
  Future<Either<Failure, MovieR>> getMovie() async {
    try {
      final result = await movieRemoteDataSource.getMovie();
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
}
