import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../data/services/firebase_auth.dart';

///Control para el acceso a la aplicacion
class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  //bandera de carga
  RxBool isLoading = false.obs;
  //mensaje de error
  RxString errorMessage = "".obs;

  Future<void> login(String email, String password) async {
    //limpiando errores previos
    errorMessage.value = "";

    isLoading.value = true;

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = "Todos los campos son obligatorios";
      isLoading.value = false;
      return;
    }
    final user = await _authService.signInWithEmail(email, password);
    isLoading.value = false;
    if (user != null) {
      final userController = Get.put(UserController());
      userController.email.value = email;
      Get.offAllNamed(AppRoutes.home);
    } else {
      errorMessage.value = "Credenciales incorrectas";
    }
  }

  Future<void> register(String email, String password) async {
    errorMessage.value = "";

    isLoading.value = true;

    final user = await _authService.registerWithEmail(email, password);

    isLoading.value = false;

    if (user != null) {
      Get.toNamed(AppRoutes.login);
    } else {
      errorMessage.value = "No se pudo registrar el usuario";
    }
  }

  @override
  void onInit() {
    super.onInit();

    ever(errorMessage, (String msg) {
      if (msg.isNotEmpty) {
        Get.snackbar("Atención", msg, snackPosition: SnackPosition.TOP);
      }
    });
  }
}
