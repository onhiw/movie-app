import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/utils/exception.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const baseUrl =
      'https://api.themoviedb.org/3/discover/movie?include_adult=false';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Movies', () {
    final tMovieList = (readJson('dummy_data/movie.json') as List)
        .map((x) => MovieModel.fromJson(json.decode(x)))
        .toList();

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(baseUrl))).thenAnswer(
          (_) async => http.Response(readJson('dummy_data/movie.json'), 200));
      // act
      final result = await dataSource.getMovie("now_playing");
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(baseUrl)))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovie("now_playing");
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
