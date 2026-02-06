import 'package:body_tech_app/config/tmdb_config.dart';
import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie; // Recibimos la película

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: container(),
    );
  }

  Widget container() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen de fondo (backdrop)
            imageBackdrop(),
            info(),
          ],
        ),
      ),
    );
  }

  Widget imageBackdrop() {
    return Image.network(
      '${TmdbConfig.imageBaseUrl}${movie.backdropPath}',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300], // Fondo gris de respaldo
          child: const Center(
            child: Column(
              children: [
                Icon(
                  Icons.broken_image, // Icono de imagen rota
                  color: Colors.grey,
                  size: 100,
                ),
                Text('Sin imagen'),
              ],
            ),
          ),
        );
      },
      width: double.infinity,
      height: 250,
    );
  }

  Widget info() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('⭐ ${movie.voteAverage} | 📅 ${movie.releaseDate}'),
          const SizedBox(height: 16),
          const Text(
            'Resumen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(movie.overview),
        ],
      ),
    );
  }
}
