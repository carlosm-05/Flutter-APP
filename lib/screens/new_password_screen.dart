import 'package:flutter/material.dart';
import '../widgets.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String correo;
  const NewPasswordScreen({super.key, required this.correo});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final clave = TextEditingController();
  final confirmar = TextEditingController();
  bool ocultar = true;
  bool ocultarConfirmar = true;
  String error = '';

  bool get largo => clave.text.length >= 8;
  bool get mayuscula => RegExp(r'[A-Z]').hasMatch(clave.text);
  bool get numero => RegExp(r'[0-9]').hasMatch(clave.text);

  @override
  void dispose() { clave.dispose(); confirmar.dispose(); super.dispose(); }

  void guardar() {
    final nuevoError = (!largo || !mayuscula || !numero)
        ? 'La contraseña no cumple los requisitos'
        : (clave.text != confirmar.text ? 'Las contraseñas no coinciden' : '');
    setState(() => error = nuevoError);
    if (nuevoError.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña restablecida correctamente')));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
    }
  }

  Widget requisito(bool ok, String texto) => Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(children: [
      Icon(ok ? Icons.check_circle : Icons.circle_outlined, size: 14, color: ok ? Colors.green : Colors.grey),
      const SizedBox(width: 6),
      Text(texto, style: TextStyle(fontSize: 11, color: ok ? Colors.green : Colors.grey)),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const BackButtonSimple(),
        const SizedBox(height: 12),
        const Icon(Icons.lock, color: Colors.white, size: 28),
        const SizedBox(height: 18),
        const Text('Crea una nueva contraseña', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: texto)),
        const SizedBox(height: 8),
        const Text('Tu nueva contraseña debe ser diferente a las que usaste antes.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 24),
        AppInput(label: 'Nueva contraseña', hint: 'Contraseña', controller: clave, password: true, obscure: ocultar, onEye: () => setState(() => ocultar = !ocultar)),
        const SizedBox(height: 14),
        AppInput(label: 'Confirmar contraseña', hint: 'Repite la contraseña', controller: confirmar, password: true, obscure: ocultarConfirmar, onEye: () => setState(() => ocultarConfirmar = !ocultarConfirmar)),
        const SizedBox(height: 10),
        requisito(largo, 'Mínimo 8 caracteres'),
        requisito(mayuscula, 'Al menos una mayúscula'),
        requisito(numero, 'Al menos un número'),
        if (error.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 8), child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 11))),
        const SizedBox(height: 18),
        AppButton(text: 'Restablecer contraseña', onPressed: guardar),
      ]),
    ));
  }
}
