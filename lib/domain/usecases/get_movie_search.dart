import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

class GetMovieSearch {
  final MovieRepository movieRepository;

  GetMovieSearch(this.movieRepository);

  Future<Either<Failure, MovieR>> execute(String query) {
    return movieRepository.getMovieSearch(query);
  }
}
