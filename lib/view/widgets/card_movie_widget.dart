import 'package:body_tech_app/config/tmdb_config.dart';
import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:flutter/material.dart';

class CardMovieWidget extends StatelessWidget {
  MovieModel atrMovie;
  String? atrPosterLink;
  String? atrTitle;
  double? atrPoints;
  CardMovieWidget({super.key, required this.atrMovie}) {
    atrTitle = atrMovie.title;
    atrPoints = atrMovie.voteAverage;
    atrPosterLink = '${TmdbConfig.imageBaseUrl}${atrMovie.posterPath}';
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      elevation: 4,
      //border redondeados
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //Stack permite posicionar elementos sobre elementos, con el arguemento positioned
      child: SizedBox(child: cardInfo()),
    );
  }

  Widget cardInfo() {
    return Column(children: [image(), points(), title()]);
  }

  Widget image() {
    return ClipRRect(
      //border redondeador en la parte superior
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child:
          atrPosterLink != null
              ? SizedBox(
                height: 400,
                //horizontalmente la imagen toma todo el espacio disponible
                width: double.infinity,
                child: Image.network(
                  atrPosterLink!,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          SizedBox.expand(child: Icon(Icons.broken_image)),
                ),
              )
              : SizedBox.expand(child: Icon(Icons.broken_image)),
    );
  }

  Widget title() {
    return Text(
      atrTitle ?? '',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  //TODO: hacer que los puntos se muestren el la esquina de la imagen, para mas flow :v
  Widget points() {
    return Text('⭐ ${atrPoints.toString()}');
  }
}
