import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/datasources/db/database_helper.dart';
import 'package:movie_app/data/datasources/movie_local_data_source.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_movie.dart';
import 'package:movie_app/domain/usecases/get_movie_search.dart';
import 'package:movie_app/domain/usecases/get_movie_video.dart';
import 'package:movie_app/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_app/domain/usecases/get_watchlist_status.dart';
import 'package:movie_app/domain/usecases/remove_watchlist.dart';
import 'package:movie_app/domain/usecases/save_watchlist.dart';
import 'package:movie_app/persentation/bloc/movie-bloc/movie_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-search-bloc/movie_search_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-watchlist-bloc/movie_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => MovieBloc(locator()));
  locator.registerFactory(() => MovieVideoBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => MovieWatchlistBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetMovie(locator()));
  locator.registerLazySingleton(() => GetMovieVideo(locator()));
  locator.registerLazySingleton(() => GetMovieSearch(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
      movieRemoteDataSource: locator(), localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
