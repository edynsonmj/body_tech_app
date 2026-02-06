import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final UserController _userController = Get.find<UserController>();
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
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _showUserMenu(_userController.email.value),
          ),
        ],
      ),
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
                // Aquí haces logout
                Get.back(); // cierra el bottom sheet
                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget container() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add, size: 96),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
