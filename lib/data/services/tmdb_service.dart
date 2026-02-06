import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/network/dio_client.dart';
import 'package:dio/dio.dart';

class TmdbService {
  final Dio _dio = DioClient().dio;

  ///Obtiene las peliculas mas populares
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await _dio.get('/movie/popular');

      final List results = response.data['results'];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Error TMDb: ${e.message}');
    }
  }
}
