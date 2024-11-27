part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {}

class FetchMovie extends MovieEvent {
  final String? type;

  FetchMovie({@required this.type});

  @override
  List<Object?> get props => [];
}
