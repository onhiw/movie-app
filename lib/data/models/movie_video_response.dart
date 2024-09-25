import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_video_model.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';

class MovieVideoResponse extends Equatable {
  final int? id;
  final List<MovieVideoModel>? results;

  MovieVideoR toEntity() {
    return MovieVideoR(
        id: id, results: results?.map((e) => e.toEntity()).toList());
  }

  const MovieVideoResponse({
    this.id,
    this.results,
  });

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) =>
      MovieVideoResponse(
        id: json["id"],
        results: json["results"] == null
            ? []
            : List<MovieVideoModel>.from(
                json["results"]!.map((x) => MovieVideoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [id, results];
}
