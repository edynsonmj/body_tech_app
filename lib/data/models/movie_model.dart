///Modelo de la informacion de una pelicula
class MovieModel {
  final String posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;

  MovieModel({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

  /// Factory method para crear la instancia a partir de un json
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      // Usamos '??' para evitar errores si la API envía valores nulos
      posterPath: json['poster_path'] ?? '',
      adult: json['adult'] ?? false,
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] ?? 0,
      originalTitle: json['original_title'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      title: json['title'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      video: json['video'] ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
