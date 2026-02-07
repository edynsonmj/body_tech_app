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

  ///contendor de los 2 bloques principales, informacion principal y resumen
  Widget container() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [mainSeccion(), resumen()]),
      ),
    );
  }

  ///main seccion posee las imagenes back y poster y la informacion textual mas importante, la idea es generar un efecto visual interesante en esta area, que destaque
  Widget mainSeccion() {
    return Stack(
      children: [
        back(),
        //importante definir almenos 3 puntos referentes para evitar problemas al renderizar
        Positioned(left: 5, right: 5, bottom: 0, child: header()),
      ],
    );
  }

  ///Contiene la informacion textual mas importante, titulo, puntuacion, fecha y el poster
  Widget header() {
    return Row(
      children: [
        poster(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('⭐ ${movie.voteAverage}'),
              Text('📅 ${movie.releaseDate}'),
            ],
          ),
        ),
      ],
    );
  }

  ///imagen poster
  Widget poster() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          //horizontalmente la imagen toma todo el espacio disponible
          width: 100,
          child: Image.network(
            '${TmdbConfig.imageBaseUrl}${movie.posterPath}',
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) => Container(
                  height: 150,
                  width: 100,
                  color: Colors.black,
                  child: Icon(Icons.broken_image, color: Colors.white),
                ),
          ),
        ),
      ),
    );
  }

  Widget back() {
    return Column(children: [imageDegradado(), SizedBox(height: 100)]);
  }

  ///aplica un degrado sobre la imagen back
  Widget imageDegradado() {
    return Stack(
      children: [
        imageBackdrop(),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.7),
                  Colors.white,
                ],
                stops: const [0, 0.3, 0.8, 1],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///posee la imagenbackdrop de presentacion, ocupa todo el espacio horizontal
  Widget imageBackdrop() {
    Widget image = Image.network(
      '${TmdbConfig.imageBaseUrl}${movie.backdropPath}',
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black, // Fondo gris de respaldo
          child: const Center(
            child: Column(
              children: [
                Icon(
                  Icons.broken_image, // Icono de imagen rota
                  color: Colors.white,
                  size: 100,
                ),
              ],
            ),
          ),
        );
      },
      width: double.infinity,
    );
    return image;
  }

  ///posee el resumen de la pelicula
  Widget resumen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
