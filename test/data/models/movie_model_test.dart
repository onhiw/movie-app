import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/entities/movie.dart';

void main() {
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

  test('should be a subclass of movie entity', () async {
    final result = movieModel.toEntity();
    expect(result, movie);
  });
}
