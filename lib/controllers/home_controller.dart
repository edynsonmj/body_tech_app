import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/services/tmdb_service.dart';
import 'package:body_tech_app/view/screens/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TmdbService _service = TmdbService();

  //bandera de carga
  var isLoading = false.obs;
  //bandera de mas datos
  var isLoadingMore = false.obs;
  //bandera de error
  var error = ''.obs;
  //data consultada
  var movies = <MovieModel>[].obs;

  int currentPage = 1;
  int totalPages = 1;
  //scroll controller para paginacion -> pagina infinita
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    //escuchamos al scrolllistener
    scrollController.addListener(_scrollListener);
    //consultar api al abrir la vista home
    loadMovies();
  }

  void _scrollListener() {
    //verirfica cuando se llega al final de la lista
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Si llegamos al final y hay más páginas
      if (currentPage < totalPages) {
        currentPage++; // Incrementar página
        loadMovies(isNextPage: true); // Cargar la siguiente
      }
    }
  }

  ///consulta las peliculas mas populares
  Future<void> loadMovies({bool isNextPage = false}) async {
    try {
      if (isNextPage) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
      }
      error.value = '';
      //llamado al servicio
      final result = await _service.getPopularMovies(
        page: currentPage,
        onPaginationInfo: (newCurrent, newTotal) {
          currentPage = newCurrent;
          totalPages = newTotal;
        },
      );
      //reemplazar todos los datos por result
      if (currentPage == 1) {
        movies.assignAll(result);
        //si la pagina ya no es 1, incremente la lista
      } else {
        movies.addAll(result); // <--- Usar addAll para paginación
      }
    } catch (e) {
      error.value = e.toString();
      //TODO: modificar mensaje de error
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void goToDetail(MovieModel movie) {
    Get.to(() => MovieDetailPage(movie: movie));
  }
}
