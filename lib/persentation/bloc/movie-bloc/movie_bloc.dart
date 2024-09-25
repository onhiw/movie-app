import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/usecases/get_movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovie getMovie;
  MovieBloc(this.getMovie) : super(MovieInitial()) {
    on<FetchMovie>(_fetchMovie);
  }

  Future<void> _fetchMovie(FetchMovie event, Emitter<MovieState> emit) async {
    emit(MovieLoading());

    final data = await getMovie.execute();

    data.fold((failure) {
      emit(MovieError(failure.message));
    }, (success) {
      emit(MovieLoaded(success));
    });
  }
}
