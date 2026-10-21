import 'package:flutter/material.dart';
import '../widgets.dart';
import 'code_screen.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final correo = TextEditingController();
  String error = '';

  @override
  void dispose() { correo.dispose(); super.dispose(); }

  void enviar() {
    final nuevoError = correo.text.trim().isEmpty
        ? 'Escribe tu correo electrónico'
        : (!correoValido(correo.text) ? 'Escribe un correo válido' : '');
    setState(() => error = nuevoError);
    if (nuevoError.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CodeScreen(correo: correo.text.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const BackButtonSimple(),
        const SizedBox(height: 22),
        Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.mail_outline, color: Colors.white)),
        const SizedBox(height: 20),
        const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: texto)),
        const SizedBox(height: 8),
        const Text('Ingresa el correo con el que te registraste y te enviaremos un código de 4 dígitos.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 26),
        AppInput(label: 'Correo electrónico', hint: 'tu@correo.com', controller: correo, keyboardType: TextInputType.emailAddress),
        if (error.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 5), child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 11))),
        const SizedBox(height: 18),
        AppButton(text: 'Enviar código', onPressed: enviar),
        const SizedBox(height: 20),
        Center(child: Wrap(children: [
          const Text('¿La recordaste? ', style: TextStyle(fontSize: 11, color: Colors.grey)),
          GestureDetector(onTap: () => Navigator.pop(context), child: const Text('Inicia sesión', style: TextStyle(fontSize: 11, color: Colors.deepPurple))),
        ])),
      ]),
    ));
  }
}
