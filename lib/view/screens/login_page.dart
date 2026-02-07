import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  final LoginController controller = Get.put(LoginController());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return safeScaffold();
  }

  Widget safeScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: SafeArea(child: SingleChildScrollView(child: container())),
    );
  }

  Widget container() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headerIcon(),
              const SizedBox(height: 20),
              emailField(),
              const SizedBox(height: 20),
              passField(),
              const SizedBox(height: 20),
              loginButton(),
              const SizedBox(height: 20),
              dataButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerIcon() {
    return const CircleAvatar(radius: 75, child: Icon(Icons.person, size: 100));
  }

  Widget emailField() {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: "Correo electronico",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "El correo es obligatorio";
        }
        if (!GetUtils.isEmail(value)) {
          return "Correo no válido";
        }
        return null;
      },
    );
  }

  Widget passField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: "Contraseña",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.password),
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "La contraseña es obligatoria";
        }
        if (value.length < 6) {
          return "No cumple los requisitos";
        }
        return null;
      },
    );
  }

  Widget loginButton() {
    return Obx(() {
      return FilledButton(
        onPressed:
            controller.isLoading.value
                ? null
                : () {
                  _summitForm();
                },
        child:
            controller.isLoading.value
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : const Text('Iniciar sesión'),
      );
    });
  }

  void _summitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      return;
    }
    controller.login(email, password);
  }

  Widget dataButton() {
    return Obx(() {
      if (controller.isLoading.value == false) {
        return TextButton(
          onPressed: () {
            controller.errorMessage.value = "";
            _formKey.currentState?.reset();
            Get.toNamed(AppRoutes.register);
          },
          child: Text('Registrarse'),
        );
      } else {
        return Text('cargando');
      }
    });
  }
}
