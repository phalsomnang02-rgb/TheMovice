
import "package:flutter_application_1/movie_module/models/movie_search_screen.dart";
import "package:flutter_application_1/movie_module/models/person_detail_model.dart";
import "package:flutter_application_1/movie_module/models/person_model.dart";
import "package:http/http.dart" as http;
import "package:flutter/foundation.dart";
import "package:flutter_application_1/movie_module/utils/api_key.dart";
import "../models/the_movie_model.dart";
import "../models/movie_detail_model.dart";

class TheMovieServices {
  final baseUrl = "https://api.themoviedb.org/3/movie";

  Future<TheMovie> read() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/now_playing?language=en-US&page=1&api_key=$apikey"),
      );
      if (response.statusCode == 200) {
        return compute(theMovieFromJson, response.body);
      } else {
        throw Exception("Error status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<MovieDetail> get(String movieId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$movieId?language=en-US&api_key=$apikey"),
      );
      if (response.statusCode == 200) {
        return compute(movieDetailFromJson, response.body);
      } else {
        throw Exception("Error status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }

  }


  Future<PersonPopular> getPopularPeople() async {
  final response = await http.get(
    Uri.parse(
      "https://api.themoviedb.org/3/person/popular?language=en-US&page=1&api_key=$apikey",
    ),
  );

  if (response.statusCode == 200) {
    return compute(
      peoplePopularFromJson,
      response.body,
    );
  } else {
    throw Exception(
      "Error status code ${response.statusCode}",
    );
  }
}



Future<PersonDetail> getPersonDetail(String personId) async {
  try {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/person/$personId?language=en-US&api_key=$apikey",
      ),
    );

    if (response.statusCode == 200) {
      return compute( personDetailFromJson,  response.body);
    } else {
      throw Exception(
        "Error status code ${response.statusCode}",
      );
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


  Future<MovieseachScreen> search(String query) async {
    // Your API fetching logic here
    // Example:
    // final response = await http.get(Uri.parse('https://api.../search?query=$query'));
    // return MovieseachScreen.fromJson(jsonDecode(response.body));

  try {
    final response = await http.get(
      Uri.parse(
        "https://api.themoviedb.org/3/search/movie?language=en-US&query=$query&page=1&api_key=$apikey",
      ),
    );

    if (response.statusCode == 200) {
      return compute(movieseachScreenFromJson,  response.body);
    } else {
      throw Exception(
        "Error status code ${response.statusCode}",
      );
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
}

