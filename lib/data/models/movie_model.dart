import 'package:hive/hive.dart';

part 'movie_model.g.dart';

///Modelo de la informacion de una pelicula
@HiveType(typeId: 0)
class MovieModel extends HiveObject {
  @HiveField(0)
  final String posterPath;
  @HiveField(1)
  final bool adult;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  final String releaseDate;
  @HiveField(4)
  final List<int> genreIds;
  @HiveField(5)
  final int id;
  @HiveField(6)
  final String originalTitle;
  @HiveField(7)
  final String originalLanguage;
  @HiveField(8)
  final String title;
  @HiveField(9)
  final String backdropPath;
  @HiveField(10)
  final double popularity;
  @HiveField(11)
  final int voteCount;
  @HiveField(12)
  final bool video;
  @HiveField(13)
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
