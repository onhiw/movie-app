import 'package:flutter/material.dart';
import 'package:movie_app/persentation/pages/now-playing/now_playing_page.dart';
import 'package:movie_app/persentation/pages/upcoming/upcoming_page.dart';
import 'package:movie_app/styles/colors.dart';
import 'package:movie_app/utils/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
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
                Navigator.pushNamed(context, watchlistMovieRoute);
              },
              icon: const Icon(Icons.bookmark)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, searchMovieRoute);
              },
              icon: const Icon(Icons.search)),
        ],
        bottom: TabBar(controller: tabController, tabs: const [
          Tab(
            text: "Now Playing",
          ),
          Tab(
            text: "Upcoming",
          ),
        ]),
      ),
      body: TabBarView(controller: tabController, children: const [
        NowPlayingPage(),
        UpcomingPage(),
      ]),
    );
  }
}
