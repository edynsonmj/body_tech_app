import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/network/dio_client.dart';
import 'package:dio/dio.dart';

typedef PaginationCallBack = void Function(int currentPage, int totalPages);

class TmdbService {
  final Dio _dio = DioClient().dio;

  ///Obtiene las peliculas mas populares
  Future<List<MovieModel>> getPopularMovies({
    //valor por defecto para la pagina
    int page = 1,
    //funcion callback para obtener informacion de la paginacion
    PaginationCallBack? onPaginationInfo,
  }) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      final int currentPage = response.data['page'];
      final int totalPages = response.data['total_pages'];
      //si el controlador envia un callback cargamos la informacion
      if (onPaginationInfo != null) {
        onPaginationInfo(currentPage, totalPages);
      }
      //se obtienen los resultados
      final List results = response.data['results'];
      //se da formato y retornan
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Error TMDb: ${e.message}');
    }
  }
}
