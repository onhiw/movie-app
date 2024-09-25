import 'dart:convert';

import 'package:movie_app/data/models/movie_response.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_video_response.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/exception.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponse> getMovie();
  Future<MovieVideoResponse> getMovieVideo(String id);
  Future<MovieResponse> getMovieSearch(String query);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<MovieResponse> getMovie() async {
    final response = await client.get(
        Uri.parse('$baseUrl/discover/movie?include_adult=false'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieVideoResponse> getMovieVideo(String id) async {
    final response = await client.get(
        Uri.parse('$baseUrl/movie/$id/videos?language=en-US'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return MovieVideoResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieResponse> getMovieSearch(String query) async {
    final response = await client.get(
        Uri.parse(
            '$baseUrl/search/movie?query=$query&include_adult=false&language=en-US&page=1'),
        headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
