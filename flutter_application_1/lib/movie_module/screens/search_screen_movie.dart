// import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/movie_module/logics/movie_gridstyle_logic.dart';
import 'package:flutter_application_1/movie_module/logics/movie_theme_logic.dart';
import 'package:flutter_application_1/movie_module/models/movie_search_screen.dart'; 
import 'package:flutter_application_1/movie_module/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../services/the_movie_services.dart'; // ប្រើប្រាស់ Service មួយនេះ

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  bool _showUpIcon = false;
  bool _gridStyle = true;
  final _searchCtrl = TextEditingController();
  final ScrollController _scroller = ScrollController();
  final TheMovieServices _movieServices = TheMovieServices();
  late Future<MovieseachScreen> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _movieServices.search(_searchCtrl.text.trim());

    _scroller.addListener(() {
      if (_scroller.position.pixels < 500) {
        if (_showUpIcon) setState(() => _showUpIcon = false);
      } else {
        if (!_showUpIcon) setState(() => _showUpIcon = true);
      }
    });
  }

  @override
  void dispose() {
    _scroller.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _searchMovies() {
    setState(() {
      _futureData = _movieServices.search(_searchCtrl.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _showUpIcon ? _buildFloating() : null,
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {

    bool dark = context.watch<MovieThemeLogic>().dark;
    _gridStyle = context.watch<MovieGridstyleLogic>().gridStyle;
    return AppBar(
      title: TextField(
        controller: _searchCtrl,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black),
          hintText: "Search movies...",
          hintStyle: TextStyle(color: Colors.black54),
        ),
        onSubmitted: (text) => _searchMovies(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async => _searchMovies(),
        child: FutureBuilder<MovieseachScreen>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.error.toString()),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _searchMovies,
                    child: const Text("RETRY"),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return _buildGridView(snapshot.data);
            } else {
              return _buildSkeletonizer();
            }
          },
        ),
      ),
    );
  }

  Widget _buildGridView(MovieseachScreen? data) {
    if (data == null || data.results.isEmpty) {
      return const Center(
        child: Icon(Icons.movie_creation_outlined, size: 64)
        
        );
    }

    final movies = data.results; 
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    double screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1000 ? (screenWidth - 1000) / 2 : 8,
        vertical: 8,
      ),
      controller: _scroller,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridStyle ? (isLandscape ? 4 : 2) : 1,
        childAspectRatio: _gridStyle ? 3 / 5 : 3 / 2,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MovieDetailScreen(movie.id.toString()),
              ),
            );
          },
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), 
                    child: CachedNetworkImage(
                      imageUrl: movie.posterPath != null
                          ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
                          : "https://via.placeholder.com/500x750?text=No+Image",
                      placeholder: (_, _) => Container(color: Colors.grey.shade300),
                      errorWidget: (_, _, _) => Container(color: Colors.grey.shade400),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie.title ?? "Unknown Title",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonizer() {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    double screenWidth = MediaQuery.of(context).size.width;

    return Skeletonizer(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 1000 ? (screenWidth - 1000) / 2 : 8,
          vertical: 8,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _gridStyle ? (isLandscape ? 4 : 2) : 1,
          childAspectRatio: _gridStyle ? 3 / 5 : 3 / 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), 
                    child: Container(
                      width: double.maxFinite,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Loading Movie Title..."),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () {
        _scroller.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.arrow_upward),
    );
  }
}
