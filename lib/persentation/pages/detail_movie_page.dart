// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/domain/entities/movie.dart';
// import 'package:movie_app/persentation/bloc/movie-video-bloc/movie_video_bloc.dart';
// import 'package:movie_app/styles/colors.dart';

// class DetailMoviePage extends StatefulWidget {
//   final Movie? movie;
//   const DetailMoviePage({super.key, @required this.movie});

//   @override
//   State<DetailMoviePage> createState() => _DetailMoviePageState();
// }

// class _DetailMoviePageState extends State<DetailMoviePage> {
//   @override
//   void initState() {
//     _fetchMovie();
//     super.initState();
//   }

//   void _fetchMovie() {
//     Future.microtask(() {
//       context
//           .read<MovieVideoBloc>()
//           .add(FetchMovieVideo(id: widget.movie!.id.toString()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: false,
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: textColor),
//         automaticallyImplyLeading: false,
//         title: Text(
//           widget.movie!.title!,
//           style: const TextStyle(
//               color: textColor, fontWeight: FontWeight.w700, fontSize: 16),
//         ),
//       ),
//       body: BlocListener<MovieVideoBloc, MovieVideoState>(
//         listener: (context, state) {
//           if (state is MovieVideoLoaded) {}
//         },
//         child: BlocBuilder<MovieVideoBloc, MovieVideoState>(
//           builder: (context, state) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
