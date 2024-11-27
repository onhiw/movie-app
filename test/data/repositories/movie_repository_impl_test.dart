import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/models/movie_response.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/utils/exception.dart';
import 'package:movie_app/utils/failure.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    repository = MovieRepositoryImpl(
        movieRemoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource);
  });

  const movieModel = MovieModel(
      adult: false,
      backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
      id: 533535,
      originalLanguage: 'en',
      originalTitle: 'Deadpool & Wolverine',
      overview: 'A listless Wade Wilson',
      popularity: 2225.512,
      posterPath: '/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      title: 'Deadpool & Wolverine',
      video: false,
      voteAverage: 7.7,
      voteCount: 3168);

  var movie = Movie(
      adult: false,
      backdropPath: '/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg',
      id: 533535,
      originalLanguage: 'en',
      originalTitle: 'Deadpool & Wolverine',
      overview: 'A listless Wade Wilson',
      popularity: 2225.512,
      posterPath: '/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg',
      title: 'Deadpool & Wolverine',
      video: false,
      voteAverage: 7.7,
      voteCount: 3168);

  final tMovieModelList = <MovieModel>[movieModel];
  final tMovieList = <Movie>[movie];

  group('Movies', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovie("now_playing")).thenAnswer(
          (_) async => MovieResponse(results: tMovieModelList.toList()));
      // act
      final result = await repository.getMovie("now_playing");
      // assert
      verify(mockRemoteDataSource.getMovie("now_playing"));

      final resultList =
          result.getOrElse(() => const MovieResponse(results: []).toEntity());
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getMovie("now_playing"))
          .thenThrow(ServerException());
      // act
      final result = await repository.getMovie("now_playing");
      // assert
      verify(mockRemoteDataSource.getMovie("now_playing"));
      expect(
          result,
          equals(const Left(ServerFailure(
              'Oops, An error occurred while connecting to the server'))));
    });
  });
}
