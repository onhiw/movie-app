import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/persentation/bloc/movie-bloc/movie_bloc.dart';
import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';
import 'package:movie_app/persentation/pages/search_movie_page.dart';
import 'package:movie_app/persentation/widgets/loading_indicator.dart';
import 'package:movie_app/styles/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _controller;

  late PlayerState playerState;
  late YoutubeMetaData videoMetaData;
  bool isPlayerReady = false;

  @override
  void initState() {
    _fetchMovie();
    super.initState();
  }

  void _fetchMovie() {
    Future.microtask(() {
      context.read<MovieBloc>().add(FetchMovie());
    });
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Movie App",
          style: TextStyle(
              color: textColor, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearchMoviePage();
                }));
              },
              icon: const Icon(Icons.search))
        ],
      ),
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

  void listener() {
    if (isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        playerState = _controller.value.playerState;
        videoMetaData = _controller.metadata;
      });
    }
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
