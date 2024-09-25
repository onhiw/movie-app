import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entities/movie_video_r.dart';
import 'package:movie_app/domain/usecases/get_movie_video.dart';

part 'movie_video_event.dart';
part 'movie_video_state.dart';

class MovieVideoBloc extends Bloc<MovieVideoEvent, MovieVideoState> {
  final GetMovieVideo getMovieVideo;
  MovieVideoBloc(this.getMovieVideo) : super(MovieVideoInitial()) {
    on<FetchMovieVideo>(_fetchMovie);
  }

  Future<void> _fetchMovie(
      FetchMovieVideo event, Emitter<MovieVideoState> emit) async {
    emit(MovieVideoLoading());

    final data = await getMovieVideo.execute(event.id!);

    data.fold((failure) {
      emit(MovieVideoError(failure.message));
    }, (success) {
      emit(MovieVideoLoaded(success));
    });
  }
}
