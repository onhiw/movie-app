import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/persentation/bloc/movie-search-bloc/movie_search_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';
import 'package:movie_app/persentation/widgets/loading_indicator.dart';
import 'package:movie_app/styles/colors.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({super.key});

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  late YoutubePlayerController _controller;
  TextEditingController search = TextEditingController();
  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;

  void _fetchMovie(String query) {
    Future.microtask(() {
      context.read<MovieSearchBloc>().add(FetchMovieSearch(query: query));
    });
  }

  void listener() {
    if (isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        playerState = _controller.value.playerState;
        videoMetaData = _controller.metadata;
      });
    }
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
        titleSpacing: 0,
        title: Container(
          height: 45.0,
          margin: const EdgeInsets.only(right: 16),
          child: TextFormField(
            controller: search,
            onFieldSubmitted: (value) {
              _fetchMovie(value);
            },
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45.0),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45.0),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: BlocBuilder<MovieSearchBloc, MovieSearchState>(
        builder: (context, state) {
          if (state is MovieSearchLoading) {
            return const Center(child: LoadingIndicator());
          }
          if (state is MovieSearchLoaded) {
            return _buildList(state.movieR.results!);
          }
          if (state is MovieSearchError) {
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
            Future.microtask(() {
              context
                  .read<MovieVideoBloc>()
                  .add(FetchMovieVideo(id: item.id!.toString()));
            });

            showBarModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              builder: (context) {
                return Builder(builder: (context) {
                  return Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: BlocListener<MovieVideoBloc, MovieVideoState>(
                      listener: (context, state) {
                        if (state is MovieVideoLoaded) {
                          String id = state.movieVideoR.results!
                                  .where((element) =>
                                      element.name == "Official Trailer" &&
                                      element.type == "Trailer")
                                  .isEmpty
                              ? "gvg26ZI5s-A"
                              : state.movieVideoR.results!
                                  .where((element) =>
                                      element.name == "Official Trailer" &&
                                      element.type == "Trailer")
                                  .first
                                  .key!;
                          _controller = YoutubePlayerController(
                            initialVideoId: id,
                            flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                loop: false,
                                enableCaption: true,
                                isLive: false,
                                forceHD: false,
                                hideControls: false,
                                showLiveFullscreenButton: false),
                          );
                        }
                      },
                      child: BlocBuilder<MovieVideoBloc, MovieVideoState>(
                        builder: (context, state) {
                          if (state is MovieVideoLoading) {
                            return const Center(child: LoadingIndicator());
                          }
                          if (state is MovieVideoLoaded) {
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: YoutubePlayer(
                                        controller: _controller,
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.amber,
                                        progressColors: const ProgressBarColors(
                                          playedColor: Colors.amber,
                                          handleColor: Colors.amberAccent,
                                        ),
                                        bottomActions: [
                                          const SizedBox(width: 14.0),
                                          CurrentPosition(),
                                          const SizedBox(width: 8.0),
                                          Expanded(child: ProgressBar()),
                                          RemainingDuration(),
                                        ],
                                        onReady: () {
                                          _controller.addListener(listener);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 8,
                                        bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          item.releaseDate == null
                                              ? "-"
                                              : MyHelper.formatDate(
                                                  item.releaseDate!),
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          item.overview == null
                                              ? ""
                                              : item.overview!,
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (state is MovieVideoError) {
                            return Center(
                                child: Text(
                              state.message,
                              textAlign: TextAlign.center,
                            ));
                          }
                          return Container();
                        },
                      ),
                    ),
                  );
                });
              },
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
