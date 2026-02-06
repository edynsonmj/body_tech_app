import 'dart:async';

import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/services/tmdb_service.dart';
import 'package:body_tech_app/data/storage/session_manager.dart';
import 'package:body_tech_app/view/screens/login_page.dart';
import 'package:body_tech_app/view/screens/movie_detail_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeController extends GetxController {
  //servicio de peliculas
  final TmdbService _service = TmdbService();
  SessionManager _sessionManager = SessionManager();

  //caja local
  final _moviesBox = Hive.box<MovieModel>('moviesBox');

  //para el estado de la conexion
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  //bandera de conexion
  var isConnected = true.obs;

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
    //Verificar conexión inicial
    _checkInitialConnection();

    //Escuchar cambios de red
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    //escuchamos al scrolllistener
    scrollController.addListener(_scrollListener);
    //consultar api al abrir la vista home
    loadMovies();
  }

  @override
  void onClose() {
    // 3. Cancelar suscripción al cerrar el controlador
    _connectivitySubscription.cancel();
    super.onClose();
  }

  Future<void> _checkInitialConnection() async {
    List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    bool wasConnected = isConnected.value;
    bool nowConnected = !results.contains(ConnectivityResult.none);
    // Si la lista está vacía o contiene solo 'none', no hay conexión
    if (results.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      Get.snackbar(
        'Sin Conexión',
        'Funcionando en modo offline',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      isConnected.value = true;
      if (!wasConnected && nowConnected) {
        Get.snackbar(
          'Conexión Restablecida',
          'Actualizando información...',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        loadMovies(); // <--- Llamada automática a la API
      }
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      // Posponemos la acción al final del frame actual
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (isConnected.value == false) {
          // Ajuste de scroll seguro
          if (scrollController.hasClients) {
            double currentPosition = scrollController.position.pixels;
            scrollController.jumpTo(currentPosition - 50);
          }

          Get.snackbar(
            'Modo Offline',
            'No es posible cargar más datos sin conexión',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else if (currentPage < totalPages) {
          currentPage++;
          loadMovies(isNextPage: true);
        }
      });
    }
  }

  Future<bool> _hasActualInternet() async {
    try {
      // Intentamos conectar a un host fiable con un timeout muy corto
      final response = await Dio().get(
        'https://www.google.com',
        options: Options(connectTimeout: const Duration(seconds: 2)),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false; // Si hay excepción, no hay salida a internet
    }
  }

  ///consulta las peliculas mas populares
  Future<void> loadMovies({bool isNextPage = false}) async {
    bool internetReal = isConnected.value;
    if (isConnected.value) {
      internetReal = await _hasActualInternet();
      // Actualizamos nuestra bandera reactiva para reflejar la realidad
      isConnected.value = internetReal;
    }

    if (!internetReal) {
      _loadLocalData();
      return;
    }
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
      if (result.isNotEmpty) {
        _moviesBox.clear();
        _moviesBox.addAll(result);
      }
      //reemplazar todos los datos por result
      if (currentPage == 1) {
        movies.assignAll(result);
        //si la pagina ya no es 1, incremente la lista
      } else {
        movies.addAll(result);
      }
    } catch (e) {
      error.value = e.toString();
      _loadLocalData();
      //TODO: modificar mensaje de error
      Get.snackbar('Error', 'no se pudo conectar al servidor');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void _loadLocalData() {
    movies.assignAll(_moviesBox.values.toList());
  }

  void goToDetail(MovieModel movie) {
    Get.to(() => MovieDetailPage(movie: movie));
  }

  void logout() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sessionManager.logout();
      Get.offAllNamed(AppRoutes.login);
    });
  }
}
