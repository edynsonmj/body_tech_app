import 'package:body_tech_app/config/app_pages.dart';
import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/firebase_options.dart';
import 'package:body_tech_app/view/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app ffutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      initialRoute: AppRoutes.login,
      //listado de rutas
      getPages: AppPages.pages,
    );
  }
}
