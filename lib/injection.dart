import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_movie.dart';
import 'package:movie_app/domain/usecases/get_movie_search.dart';
import 'package:movie_app/domain/usecases/get_movie_video.dart';
import 'package:movie_app/persentation/bloc/movie-bloc/movie_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-search-bloc/movie_search_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => MovieBloc(locator()));
  locator.registerFactory(() => MovieVideoBloc(locator()));
  locator.registerFactory(() => MovieSearchBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetMovie(locator()));
  locator.registerLazySingleton(() => GetMovieVideo(locator()));
  locator.registerLazySingleton(() => GetMovieSearch(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(movieRemoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
}
