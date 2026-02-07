import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/controllers/home_controller.dart';
import 'package:body_tech_app/data/storage/session_manager.dart';
import 'package:body_tech_app/view/widgets/card_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  SessionManager sesion = SessionManager();
  //controlador principal
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return safeScaffold();
  }

  Widget safeScaffold() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
          //datos del usuario y cierre de sesion
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showUserMenu(sesion.getUserEmail().toString()),
          ),
        ],
      ),
      body: container(),
    );
  }

  void _showUserMenu(String email) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.email), title: Text(email)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                sesion.logout();
                Get.back();
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget container() {
    return SafeArea(
      //nuestro contenido debe observar los resultados consultados
      child: Obx(() {
        //cargando datos
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        //mostrar error
        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        //listado de peliculas encontradas
        return ListView.builder(
          controller: controller.scrollController,
          // itemCount ahora incluye un item extra si está cargando más
          itemCount: controller.movies.length + 1,
          itemBuilder: (_, i) {
            // Si llegamos al último item y está cargando más, mostramos spinner al final
            if (i == controller.movies.length) {
              return Obx(
                () =>
                    controller.isLoadingMore.value
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink(),
              );
            }

            final movie = controller.movies[i];
            return InkWell(
              child: CardMovieWidget(atrMovie: movie),
              onTap: () => controller.goToDetail(movie),
            );
          },
        );
      }),
    );
  }
}
