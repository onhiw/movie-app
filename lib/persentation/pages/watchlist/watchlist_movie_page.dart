import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/persentation/bloc/movie-watchlist-bloc/movie_watchlist_bloc.dart';
import 'package:movie_app/persentation/pages/detail_movie_page.dart';
import 'package:movie_app/persentation/widgets/loading_indicator.dart';
import 'package:movie_app/styles/colors.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/helper.dart';
import 'package:movie_app/utils/utils.dart';

class WatchlistMoviePage extends StatefulWidget {
  const WatchlistMoviePage({super.key});

  @override
  State<WatchlistMoviePage> createState() => _WatchlistMoviePageState();
}

class _WatchlistMoviePageState extends State<WatchlistMoviePage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(GetListMovieWatchlist()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(
        () => context.read<MovieWatchlistBloc>().add(GetListMovieWatchlist()));
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: textColor),
        title: const Text(
          "Watchlist Movie",
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
          builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is MovieWatchlistInitial) {
          return const Center(
              child: Text(
            'Belum ada data',
          ));
        } else if (state is MovieWatchlistLoaded) {
          return _buildList(state.movie);
        } else if (state is MovieWatchlistError) {
          return const Text("Terjadi kesalahaan saat memuat data");
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _buildList(List<Movie> movie) {
    return StaggeredGridView.count(
      padding: const EdgeInsets.all(16),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      staggeredTiles: List.generate(movie.length, (index) {
        return const StaggeredTile.fit(1);
      }),
      children: List.generate(movie.length, (index) {
        final item = movie[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailMoviePage(movie: item);
            }));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    item.posterPath == null
                        ? ""
                        : '$baseImageUrl${item.posterPath!}',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        item.releaseDate == null
                            ? "-"
                            : MyHelper.formatDate(item.releaseDate!),
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
