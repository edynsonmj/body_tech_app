import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/services/tmdb_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TmdbService _service = TmdbService();

  //bandera de carga
  var isLoading = false.obs;
  //bandera de error
  var error = ''.obs;
  //data consultada
  var movies = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    //consultar api al abrir la vista home
    loadMovies();
  }

  ///consulta las peliculas mas populares
  Future<void> loadMovies() async {
    try {
      isLoading.value = true;
      error.value = '';
      //llamado al servicio
      final result = await _service.getPopularMovies();
      //reemplazar todos los datos por result
      movies.assignAll(result);
    } catch (e) {
      error.value = e.toString();
      //TODO: modificar mensaje de error
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }
}
