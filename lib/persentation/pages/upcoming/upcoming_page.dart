import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/persentation/bloc/movie-bloc/movie_bloc.dart';
import 'package:movie_app/persentation/widgets/loading_indicator.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/helper.dart';
import 'package:movie_app/utils/routes.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  void initState() {
    _fetchMovie();
    super.initState();
  }

  void _fetchMovie() {
    Future.microtask(() {
      context.read<MovieBloc>().add(FetchMovie(type: "upcoming"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: LoadingIndicator());
          }
          if (state is MovieLoaded) {
            return _buildList(state.movieR.results!);
          }
          if (state is MovieError) {
            return Center(
                child: Text(
              state.message,
              textAlign: TextAlign.center,
            ));
          }
          return Container();
        },
      ),
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
            Navigator.pushNamed(
              context,
              detailMovieRoute,
              arguments: item,
            );
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
