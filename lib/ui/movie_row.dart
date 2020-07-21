import 'package:flutter/material.dart';
import 'package:movie_carnival/model/movie_data_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieRow extends StatelessWidget {
  final Results movie;
  const MovieRow(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Card(
                  elevation: 4,
                  child: Container(
                    constraints: BoxConstraints(
                        minHeight: 150, minWidth: double.infinity),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(150, 16, 16, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.movie.originalTitle != null
                              ? this.movie.originalTitle
                              : "",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                          child: Text(
                            (this.movie.genreIds.length == 0)
                                ? "Genre: NA"
                                : "Genre: " + getGenre(this.movie.genreIds),
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                movie.voteAverage == null
                                    ? "0"
                                    : movie.voteAverage.toString(),
                                style: TextStyle(
                                    color: const Color(0xff7173fa),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SmoothStarRating(
                                    allowHalfRating: true,
                                    starCount: 5,
                                    rating: movie.voteAverage == null
                                        ? 0
                                        : (movie.voteAverage / 2),
                                    size: 20.0,
                                    isReadOnly: true,
                                    color: const Color(0xffff6f3d),
                                    borderColor: const Color(0xffff6f3d),
                                    spacing: 0.0),
                              )
                            ])
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: this.movie.posterPath != null
                    ? Image.network(
                        "http://image.tmdb.org/t/p/w500/" +
                            this.movie.posterPath,
                        height: 150.0,
                        width: 100.0,
                      )
                    : Container(
                        color: Colors.blueAccent,
                        height: 150.0,
                        width: 100.0,
                        child: Center(
                          child: Text("No image"),
                        )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getGenre(List<int> genreIds) {
  Map<String, String> genre = {
    "28": "Action",
    "12": "Adventure",
    "16": "Animation",
    "35": "Comedy",
    "80": "Crime",
    "99": "Documentary",
    "18": "Drama",
    "10751": "Family",
    "14": "Fantasy",
    "36": "History",
    "27": "Horror",
    "10402": "Music",
    "9648": "Mystery",
    "10749": "Romance",
    "878": "Science Fiction",
    "10770": "TV Movie",
    "53": "Thriller",
    "10752": "War",
    "37": "Western"
  };
  return genre[genreIds[0].toString()];
}
