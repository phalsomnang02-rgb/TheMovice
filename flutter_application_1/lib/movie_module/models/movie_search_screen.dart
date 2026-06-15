import 'dart:convert';

MovieseachScreen movieseachScreenFromJson(String str) => MovieseachScreen.fromJson(json.decode(str));

String movieseachScreenToJson(MovieseachScreen data) => json.encode(data.toJson());

class MovieseachScreen {
    int page;
    List<MovieSearchItem> results;
    int totalPages;
    int totalResults;

    MovieseachScreen({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MovieseachScreen.fromJson(Map<String, dynamic> json) => MovieseachScreen(
        page: json["page"] ?? 1,
        results: json["results"] != null 
            ? List<MovieSearchItem>.from(json["results"].map((x) => MovieSearchItem.fromJson(x)))
            : [],
        totalPages: json["total_pages"] ?? 1,
        totalResults: json["total_results"] ?? 1,
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
class MovieSearchItem {
    int id;
    String? title;
    String? posterPath;
    String? overview;

    MovieSearchItem({
        required this.id,
        this.title,
        this.posterPath,
        this.overview,
    });

    factory MovieSearchItem.fromJson(Map<String, dynamic> json) => MovieSearchItem(
        id: json["id"],
        title: json["title"],
        posterPath: json["poster_path"], 
        overview: json["overview"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "poster_path": posterPath,
        "overview": overview,
    };
}
