import 'package:flutter/material.dart';
import 'package:movie_carnival/model/movie_provider.dart';
import 'package:movie_carnival/ui/movie_row.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).getDefaultMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(builder: (context, movieProvider, child) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: customSearchBar(movieProvider),
          ),
          body: ListView.builder(
            itemCount: movieProvider.getMovie().results.length,
            itemBuilder: (BuildContext context, int position) {
              return MovieRow(movieProvider.getMovie().results[position]);
            },
          ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  customSearchBar(MovieProvider movieProvider) {
    return Container(
      height: 40,
      child: Center(
        child: TextField(
          controller: searchController,
          onChanged: (text) {
            if (text.length == 0) {
              movieProvider.getDefaultMovies();
            }
          },
          decoration: new InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (searchController.text.length > 0) {
                      movieProvider.getMoviesByKeyword(searchController.text);
                      FocusScope.of(context).unfocus();
                    }
                  }),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.black),
              contentPadding: EdgeInsets.all(8),
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black))),
        ),
      ),
    );
  }
}
