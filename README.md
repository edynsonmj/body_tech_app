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

### 1. Instalar dependencias
* Navega hasta la raíz del proyecto o ábrelo con algún editor de texto como Visual Studio Code o Android Studio.
* En la terminal, ejecuta el siguiente comando:
    ```bash
    flutter pub get
    ```

### 2. Configuración de la llave
* Crea un archivo `.env` en la raíz del proyecto, o usa el archivo `.env.example` quitándole la extensión `.example`. El sistema intentará leer solo el archivo llamado `.env`.
* Agrega tu API key de TMDb en el campo correspondiente:
    ```env
    TMDB_API_KEY=aqui_tu_key
    ```
* La key se encuentra en el correo, o puedes usar tu propia key de [TMDb](https://www.themoviedb.org/).

### 3. Ejecución
* Usa el comando para la ejecución de la aplicación:
    ```bash
    flutter run
    ```
* Si es la primera vez que ejecutas la aplicación, probablemente te solicite seleccionar un dispositivo. Asegúrate de tener un emulador configurado o un dispositivo Android físico conectado.

## estructura del proyecto
lib/
├── config/                  # Configuración global de la app
│   ├── app_pages.dart       # Definición de páginas (GetX Pages)
│   ├── app_routes.dart      # Nombres de rutas constantes
│   └── tmdb_config.dart     # Configuración de API (Endpoints, Keys)
│
├── controllers/             # Lógica de negocio y gestión de estado (GetX)
│   ├── home_controller.dart
│   ├── login_controller.dart
│   └── user_controller.dart
│
├── data/                    # Capa de manejo de datos
│   ├── models/              # Modelos de datos y adaptadores
│   │   ├── movie_model.dart
│   │   └── movie_model.g.dart # Archivo generado (Hive/Json)
│   ├── network/             # Cliente HTTP (Dio)
│   │   └── dio_client.dart
│   ├── services/            # Servicios externos
│   │   ├── firebase_auth.dart
│   │   └── tmdb_service.dart
│   └── storage/             # Persistencia local
│       └── session_manager.dart
│
├── view/                    # Capa de Presentación (UI)
│   ├── screens/             # Pantallas completas
│   │   ├── home_page.dart
│   │   ├── login_page.dart
│   │   ├── movie_detail_page.dart
│   │   └── register_page.dart
│   └── widgets/             # Componentes reutilizables
│
├── firebase_options.dart    # Configuración generada por FlutterFire
└── main.dart                # Punto de entrada de la aplicación