import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_carnival/model/movie_data_model.dart';

class ApiClient {
  String searchBaseURL =
      "https://api.themoviedb.org/3/search/movie?api_key=YOUR_API_KEY_HERE&query=";

  Future<MovieData> getMovies() async {
    final response = await http.get(
        "http://api.themoviedb.org/3/movie/now_playing?api_key=YOUR_API_KEY_HERE");
    final responseJson = json.decode(response.body);
    return MovieData.fromJson(responseJson);
  }

  Future<MovieData> getMoviesByKeyword(String keyword) async {
    var searchKeyword = keyword.replaceAll(" ", "+");
    final response = await http.get(this.searchBaseURL + searchKeyword);
    final responseJson = json.decode(response.body);
    return MovieData.fromJson(responseJson);
  }
}
