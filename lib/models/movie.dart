class Movie {
  int? id;
  String? title;
  double? voteaverage;
  String? overview;
  String? posterpath;

  Movie(this.id, this.title, this.voteaverage, this.overview, this.posterpath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.voteaverage = parsedJson['voteaverage'] * 1.0;
    this.overview = parsedJson['overview'];
    this.posterpath = parsedJson['posterpath'];
  }
}