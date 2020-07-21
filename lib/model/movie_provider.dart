import 'package:flutter/cupertino.dart';
import 'package:movie_carnival/api/api_client.dart';
import 'package:movie_carnival/model/movie_data_model.dart';

class MovieProvider extends ChangeNotifier {
  ApiClient apiClient = ApiClient();
  MovieData _movieData = MovieData();
  List<Results> resultList = List();

  MovieProvider() {
    _movieData.results = resultList;
  }

  setMovie(MovieData movieData) {
    _movieData = movieData;
    notifyListeners();
  }

  MovieData getMovie() {
    return _movieData;
  }

  Future<void> getDefaultMovies() async {
    MovieData movieData = await apiClient.getMovies();
    setMovie(movieData);
  }

  Future<void> getMoviesByKeyword(String keyword) async {
    MovieData movieData = await apiClient.getMoviesByKeyword(keyword);
    setMovie(movieData);
  }
}
