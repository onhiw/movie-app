import 'package:dartz/dartz.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

class GetMovie {
  final MovieRepository movieRepository;

  GetMovie(this.movieRepository);

  Future<Either<Failure, MovieR>> execute(String type) {
    return movieRepository.getMovie(type);
  }
}
