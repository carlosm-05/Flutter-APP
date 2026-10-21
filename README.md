# Taller Login y Registro (Flutter)

Aplicación móvil Flutter con seis pantallas de autenticación. Es un ejercicio de interfaz: **no usa backend** y los datos se mantienen en memoria mientras la aplicación está abierta.

## Versiones

| Componente | Versión |
|------------|---------|
| Flutter | 3.29.0 (stable) |
| Dart | 3.7.0 |
| SDK constraint | `>=3.3.0 <4.0.0` |
| Material 3 | sí (`useMaterial3: true`) |

## Requisitos

- [Flutter SDK 3.29.0](https://docs.flutter.dev/get-started/install) o superior (incluye Dart).
- Android Studio, Visual Studio Code u otro editor compatible.
- Para Android: un emulador o dispositivo con depuración USB activada.
- Para iOS: Xcode (solo macOS).
- Para web: Chrome o Edge.

## Ejecutar

1. Clona el repositorio:

```bash
git clone https://github.com/carlosm-05/Flutter-APP.git
cd Flutter-APP
```

2. Descarga las dependencias y ejecuta:

```bash
flutter pub get
flutter run
```

`flutter run` compila e instala en el dispositivo conectado. Si tienes varios dispositivos, lista los disponibles con `flutter devices`.

### Ejecutar en un destino específico

```bash
# Navegador (Chrome)
flutter run -d chrome

# Emulador / dispositivo Android
flutter run -d <device-id>

# Web en modo release (más rápido)
flutter build web --release
```

## Comandos útiles

```bash
flutter analyze      # revisa errores estáticos
flutter test         # ejecuta las pruebas (si las hay)
dart format lib      # formatea el código
```

## Estructura

```
lib/
├── main.dart                      # punto de entrada (TallerApp)
├── widgets.dart                   # componentes reutilizables (AppInput, AppButton, etc.)
└── screens/
    ├── login_screen.dart          # inicio de sesión
    ├── register_screen.dart       # registro
    ├── recover_screen.dart        # recuperar contraseña
    ├── code_screen.dart           # código de verificación
    ├── new_password_screen.dart   # nueva contraseña
    └── home_screen.dart           # pantalla de inicio (tras autenticar)
```

## Pantallas y flujo

- **Login** → valida correo y contraseña.
- **Registro** → crea cuenta (valida campos, correo, contraseñas y términos).
- **Recuperar contraseña** → pide el correo.
- **Código de verificación** → cajas de 4 dígitos con temporizador.
- **Nueva contraseña** → valida requisitos (8+ caracteres, mayúscula, número).
- **Home** → pantalla de bienvenida con cierre de sesión.

Todas las pantallas de formulario muestran **mensajes de error de validación** en rojo cuando los datos no son correctos.

## Notas

- El código de verificación es simulado: se acepta cualquier combinación de cuatro dígitos.
- Google y Apple muestran un mensaje de que la función no está disponible.
- No se envían correos ni se guardan usuarios en una base de datos.
