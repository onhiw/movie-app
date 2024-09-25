import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entities/movie_r.dart';
import 'package:movie_app/domain/usecases/get_movie_search.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final GetMovieSearch getMovieSearch;
  MovieSearchBloc(this.getMovieSearch) : super(MovieSearchInitial()) {
    on<FetchMovieSearch>(_fetchMovieSearch);
  }

  Future<void> _fetchMovieSearch(
      FetchMovieSearch event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());

    final data = await getMovieSearch.execute(event.query!);

    data.fold((failure) {
      emit(MovieSearchError(failure.message));
    }, (success) {
      emit(MovieSearchLoaded(success));
    });
  }
}
