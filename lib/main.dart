import 'package:body_tech_app/config/app_pages.dart';
import 'package:body_tech_app/config/app_routes.dart';
import 'package:body_tech_app/data/models/movie_model.dart';
import 'package:body_tech_app/data/storage/session_manager.dart';
import 'package:body_tech_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cargando data sencible
  await dotenv.load(fileName: ".env");
  //iniciando firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //iniciando hive
  await Hive.initFlutter();
  //registro de adapter
  Hive.registerAdapter(MovieModelAdapter());
  //abriendo cajas para sesion y data - persistencia local
  await Hive.openBox('sessionBox');
  await Hive.openBox<MovieModel>('moviesBox');

  final sessionManager = SessionManager();
  final bool isLoggedIn = sessionManager.getUserEmail() != null ? true : false;
  runApp(MyApp(isLogging: isLoggedIn));
}

class MyApp extends StatelessWidget {
  bool isLogging;
  MyApp({super.key, required this.isLogging});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app ffutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      initialRoute: isLogging ? AppRoutes.home : AppRoutes.login,
      //listado de rutas
      getPages: AppPages.pages,
    );
  }
}
