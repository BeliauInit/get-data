import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_request/models/movie.dart';

class HttpService {
  final String baseUrl = 'https://movie.tukanginyuk.com/api/getmovie';

  Future<List?> getPopularMovies() async {
    final String uri = baseUrl;

    http.Response result = await http.get(Uri.parse(uri));

    if (result.statusCode == HttpStatus.ok) {
      print("Connected");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['data'];
      List movie = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movie;
    } else {
      print("Not Connected");
      return null;
    }
  }
}