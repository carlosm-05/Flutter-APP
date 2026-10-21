import 'package:flutter/material.dart';
import '../widgets.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String correo;
  const HomeScreen({super.key, required this.correo});

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(child: Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 88, height: 88, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [morado, rosado])), child: const Icon(Icons.person_outline, color: Colors.white, size: 42)),
          const SizedBox(height: 24),
          const Text('¡Bienvenido!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: texto)),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9), decoration: BoxDecoration(color: const Color(0xFFF1E4FF), borderRadius: BorderRadius.circular(20)), child: Text(correo, style: const TextStyle(fontSize: 12, color: Colors.deepPurple))),
          const SizedBox(height: 30),
          AppButton(text: 'Cerrar sesión', onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
          }),
        ]),
      ),
    ));
  }
}
