import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/injection.dart' as di;
import 'package:movie_app/persentation/bloc/movie-bloc/movie_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-search-bloc/movie_search_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-watchlist-bloc/movie_watchlist_bloc.dart';
import 'package:movie_app/persentation/pages/detail_movie_page.dart';
import 'package:movie_app/persentation/pages/home_page.dart';
import 'package:movie_app/persentation/pages/search_movie_page.dart';
import 'package:movie_app/persentation/pages/watchlist/watchlist_movie_page.dart';
import 'package:movie_app/utils/routes.dart';
import 'package:movie_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieVideoBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case detailMovieRoute:
              final movie = settings.arguments as Movie;
              return MaterialPageRoute(
                builder: (_) => DetailMoviePage(movie: movie),
                settings: settings,
              );
            case watchlistMovieRoute:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviePage());
            case searchMovieRoute:
              return MaterialPageRoute(builder: (_) => const SearchMoviePage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
