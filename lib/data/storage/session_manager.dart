import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SessionManager {
  final _box = Hive.box('sessionBox');

  // Guardar estado y correo
  void saveSession(String email) {
    _box.put('isLoggedIn', true);
    _box.put('userEmail', email);
  }

  // Obtener correo
  String? getUserEmail() {
    return _box.get('userEmail');
  }

  void logout() {
    _box.clear();
  }
}
