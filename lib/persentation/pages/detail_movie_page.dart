import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/persentation/bloc/movie-watchlist-bloc/movie_watchlist_bloc.dart';
import 'package:movie_app/styles/colors.dart';
import 'package:movie_app/utils/constants.dart';
import 'package:movie_app/utils/helper.dart';

class DetailMoviePage extends StatefulWidget {
  final Movie? movie;
  const DetailMoviePage({super.key, @required this.movie});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  void initState() {
    Future.microtask(() {
      context
          .read<MovieWatchlistBloc>()
          .add(GetListMovieWatchlistStatus(widget.movie!.id!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist = context.select<MovieWatchlistBloc, bool>((bloc) {
      if (bloc.state is MovieWatchlistIsAdded) {
        return (bloc.state as MovieWatchlistIsAdded).isAdded;
      }
      return false;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: textColor),
        title: Text(
          widget.movie!.title!,
          style: const TextStyle(
              color: textColor, fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.9,
        child: DetailContent(
            movie: widget.movie!, isAddedWatchlist: isAddedToWatchlist),
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final Movie movie;
  bool isAddedWatchlist;
  DetailContent({
    super.key,
    required this.movie,
    required this.isAddedWatchlist,
  });

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.movie.posterPath == null
                    ? ""
                    : '$baseImageUrl${widget.movie.posterPath!}',
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.movie.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String message = "";
                        if (!widget.isAddedWatchlist) {
                          context
                              .read<MovieWatchlistBloc>()
                              .add(MovieWatchlistAdd(widget.movie));
                        } else {
                          context
                              .read<MovieWatchlistBloc>()
                              .add(MovieWatchlistRemove(widget.movie));
                        }
                        final state =
                            BlocProvider.of<MovieWatchlistBloc>(context).state;

                        if (state is MovieWatchlistIsAdded) {
                          message = state.isAdded == false
                              ? "Added to Watchlist"
                              : "Removed from Watchlist";
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        } else {
                          message = !widget.isAddedWatchlist
                              ? "Added to Watchlist"
                              : "Removed from Watchlist";
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(message)));
                        }
                        setState(() {
                          widget.isAddedWatchlist = !widget.isAddedWatchlist;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.isAddedWatchlist
                              ? const Icon(Icons.check)
                              : const Icon(Icons.add),
                          const Text('Watchlist'),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  widget.movie.releaseDate == null
                      ? "-"
                      : MyHelper.formatDate(widget.movie.releaseDate!),
                  style: TextStyle(
                      color: Colors.grey[400], fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.movie.overview == null ? "" : widget.movie.overview!,
                  style: TextStyle(
                      color: Colors.grey[400], fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
