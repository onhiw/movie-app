import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_app/domain/usecases/get_watchlist_status.dart';
import 'package:movie_app/domain/usecases/remove_watchlist.dart';
import 'package:movie_app/domain/usecases/save_watchlist.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  MovieWatchlistBloc(this.getWatchlistMovies, this.getWatchListStatus,
      this.saveWatchlist, this.removeWatchlist)
      : super(const MovieWatchlistInitial()) {
    on<GetListMovieWatchlist>(_fetchMovieWatchlist);
    on<GetListMovieWatchlistStatus>(_fetchMovieWatchlistStatus);
    on<MovieWatchlistAdd>(_fetchMovieWatchlistAdd);
    on<MovieWatchlistRemove>(_fetchMovieWatchlistRemove);
  }

  Future<void> _fetchMovieWatchlist(
      GetListMovieWatchlist event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());
    final data = await getWatchlistMovies.execute();

    data.fold((failure) {
      emit(MovieWatchlistError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(const MovieWatchlistInitial())
          : emit(MovieWatchlistLoaded(success));
    });
  }

  Future<void> _fetchMovieWatchlistStatus(GetListMovieWatchlistStatus event,
      Emitter<MovieWatchlistState> emit) async {
    final data = await getWatchListStatus.execute(event.id);
    emit(MovieWatchlistIsAdded(data));
  }

  Future<void> _fetchMovieWatchlistAdd(
      MovieWatchlistAdd event, Emitter<MovieWatchlistState> emit) async {
    final data = await saveWatchlist.execute(event.movie);
    data.fold((failure) {
      emit(MovieWatchlistError(failure.message));
    }, (success) {
      emit(MovieWatchlistMessage(success));
    });
  }

  Future<void> _fetchMovieWatchlistRemove(
      MovieWatchlistRemove event, Emitter<MovieWatchlistState> emit) async {
    final data = await removeWatchlist.execute(event.movie);
    data.fold((failure) {
      emit(MovieWatchlistError(failure.message));
    }, (success) {
      emit(MovieWatchlistMessage(success));
    });
  }
}
