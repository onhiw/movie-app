import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_video.dart';

class MovieVideoModel extends Equatable {
  final String? name;
  final String? key;
  final String? site;
  final String? type;
  final bool? official;

  MovieVideo toEntity() {
    return MovieVideo(
        name: name, key: key, site: site, type: type, official: official);
  }

  const MovieVideoModel({
    this.name,
    this.key,
    this.site,
    this.type,
    this.official,
  });

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) =>
      MovieVideoModel(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        type: json["type"],
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "site": site,
        "type": type,
        "official": official,
      };

  @override
  List<Object?> get props => [
        name,
        key,
        site,
        type,
        official,
      ];
}
