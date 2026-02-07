import 'package:body_tech_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();

  final LoginController controller = Get.find<LoginController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return safeScaffold();
  }

  Widget safeScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro'), centerTitle: true),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: container(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget container() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                child: Icon(Icons.person_add, size: 100),
              ),
              const SizedBox(height: 24),

              emailField(),
              const SizedBox(height: 20),
              passField(),
              const SizedBox(height: 20),

              registerButton(),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Ya tengo cuenta, iniciar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() => TextFormField(
    controller: emailController,
    decoration: const InputDecoration(
      labelText: "Correo electrónico",
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.email),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) return "El correo es obligatorio";
      if (!GetUtils.isEmail(value)) return "Correo no válido";
      return null;
    },
  );

  Widget passField() => TextFormField(
    controller: passwordController,
    obscureText: true,
    decoration: const InputDecoration(
      labelText: "Contraseña",
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.lock),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) return "La contraseña es obligatoria";
      if (value.length < 6) return "Mínimo 6 caracteres";
      return null;
    },
  );

  Widget registerButton() {
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
                : const Text('Registrarse'),
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
    controller.register(email, password);
  }
}
