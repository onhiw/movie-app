import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/domain/entities/movie_r.dart';

class MovieResponse extends Equatable {
  final List<MovieModel>? results;

  MovieR toEntity() {
    return MovieR(results: results?.map((e) => e.toEntity()).toList());
  }

  const MovieResponse({
    this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        results: json["results"] == null
            ? []
            : List<MovieModel>.from(
                json["results"]!.map((x) => MovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [results];
}
