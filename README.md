# Body Tech App

[![Flutter](https://img.shields.io/badge/Flutter-SDK-blue.svg)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/StateManagement-GetX-green.svg)](https://pub.dev/packages/get)

Una aplicación móvil desarrollada con **Flutter** y **GetX** que permite a los usuarios explorar las películas más populares, ver detalles y acceder a contenido en modo **offline** utilizando **Hive** para persistencia local.



## 🚀 Características
* **Interfaz de Usuario:** Basada en Material Design con navegación fluida usando GetX.
* **Conectividad Real:** Gestión de estado de red en tiempo real (`connectivity_plus`) para cambiar entre modo online y offline sin congelar la UI.
* **Paginación Infinita:** Carga automática de películas al hacer scroll (`ScrollController`).
* **Persistencia Local:** Almacenamiento local con **Hive** para acceso rápido y modo sin conexión.
* **Manejo de Errores:** Respaldo visual (`fallback`) para imágenes rotas o sin conexión.

---

## 📦 Instalación Rápida (APK)
Si solo deseas probar la aplicación sin configurar el entorno de desarrollo, puedes instalar el archivo APK directamente en tu dispositivo Android.

1.  Descarga el archivo **`app-release.apk`** ubicado en la raíz de este repositorio.
2.  Instálalo en tu dispositivo Android (asegúrate de permitir la instalación desde fuentes desconocidas).

---

## 🛠️ Requisitos Previos
Para desarrollar o compilar este proyecto, necesitas:
* [Flutter SDK](https://docs.flutter.dev/get-started/install)
* [Android Studio](https://developer.android.com/studio) o [VS Code](https://code.visualstudio.com/)
* Un emulador o dispositivo físico Android.

---

## 💻 Instalación y Ejecución

2. instalar dependencias
* navega hasta la raiz del proyecto o abre con algun editor de texto como visual studio code o android studio
* En la terminal ejecuta el comando: flutter pub get



3. configuracion de la llave

    * Crea un archivo `.env` en la raíz del proyecto, o usa el archivo `.env.example` pero quita la extension .example, el sistema intentara leera solo el archivo llamado `.env`
    * Agrega tu API key de TMDb en el campo "aqui_tu_key": TMDB_API_KEY=aqui_tu_key
    * la key se encuentra en el correo, o usa tu propia key de TMDb movies



3. Ejecuta
    * usa el comando para ejecucion de la aplicacion: flutter run
    * si es primera vez de ejecucion probablemente te solicite seleccionar un dispositivo, asegurate de tener un emulador configurado o un dispositivo android fisico conectado

