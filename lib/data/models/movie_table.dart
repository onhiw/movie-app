import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? releaseDate;

  const MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
  });

  factory MovieTable.fromEntity(Movie movie) => MovieTable(
        id: movie.id!,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        releaseDate: movie.releaseDate.toString(),
      );

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        releaseDate: map['releaseDate'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'releaseDate': releaseDate,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        releaseDate: DateTime.parse(releaseDate!),
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview, releaseDate];
}
