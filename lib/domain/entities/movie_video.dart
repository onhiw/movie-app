import 'package:equatable/equatable.dart';

class MovieVideo extends Equatable {
  final String? name;
  final String? key;
  final String? site;
  final String? type;
  final bool? official;

  const MovieVideo({
    this.name,
    this.key,
    this.site,
    this.type,
    this.official,
  });

  @override
  List<Object?> get props => [
        name,
        key,
        site,
        type,
        official,
      ];
}
