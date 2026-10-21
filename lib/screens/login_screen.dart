import 'package:flutter/material.dart';
import '../widgets.dart';
import 'register_screen.dart';
import 'recover_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final correo = TextEditingController();
  final clave = TextEditingController();
  bool ocultar = true;
  String errorCorreo = '';
  String errorGeneral = '';

  @override
  void dispose() {
    correo.dispose();
    clave.dispose();
    super.dispose();
  }

  void iniciar() {
    final nuevoErrorCorreo = correo.text.trim().isEmpty
        ? 'Escribe tu correo electrónico'
        : (!correoValido(correo.text) ? 'Escribe un correo válido' : '');
    final nuevoErrorGeneral = clave.text.isEmpty ? 'Escribe tu contraseña' : '';
    setState(() {
      errorCorreo = nuevoErrorCorreo;
      errorGeneral = nuevoErrorGeneral;
    });
    if (nuevoErrorCorreo.isEmpty && nuevoErrorGeneral.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(correo: correo.text.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Center(child: Container(width: 48, height: 48, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [morado, rosado])), child: const Icon(Icons.lock_outline, color: Colors.white))),
              const SizedBox(height: 20),
              const Center(child: Text('Bienvenido de nuevo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: texto))),
              const Center(child: Text('Inicia sesión para continuar', style: TextStyle(fontSize: 11, color: Colors.grey))),
              const SizedBox(height: 28),
              AppInput(label: 'Correo electrónico', hint: 'tu@correo.com', controller: correo, keyboardType: TextInputType.emailAddress),
              if (errorCorreo.isNotEmpty) _error(errorCorreo),
              const SizedBox(height: 15),
              AppInput(label: 'Contraseña', hint: 'Contraseña', controller: clave, password: true, obscure: ocultar, onEye: () => setState(() => ocultar = !ocultar)),
              if (errorGeneral.isNotEmpty) _error(errorGeneral),
              Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecoverScreen())), style: TextButton.styleFrom(minimumSize: const Size(0, 42)), child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 11)))),
              const SizedBox(height: 8),
              AppButton(text: 'Iniciar sesión', onPressed: iniciar),
              const SizedBox(height: 16),
              const Center(child: Text('o continúa con', style: TextStyle(fontSize: 11, color: Colors.grey))),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: OutlinedButton(onPressed: () => _noDisponible(context), style: OutlinedButton.styleFrom(minimumSize: const Size(64, 42)), child: const Text('Google'))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => _noDisponible(context), style: OutlinedButton.styleFrom(minimumSize: const Size(64, 42)), child: const Text('Apple'))),
              ]),
              const SizedBox(height: 24),
              Center(child: Wrap(children: [
                const Text('¿No tienes cuenta? ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())), child: const Text('Regístrate', style: TextStyle(fontSize: 11, color: Colors.deepPurple, fontWeight: FontWeight.bold))),
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget _error(String mensaje) => Padding(padding: const EdgeInsets.only(top: 4), child: Text(mensaje, style: const TextStyle(color: Colors.red, fontSize: 11)));
}

void _noDisponible(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Funcionalidad no disponible')));
}
