import 'package:flutter/material.dart';
import '../widgets.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nombre = TextEditingController();
  final correo = TextEditingController();
  final clave = TextEditingController();
  final confirmar = TextEditingController();
  bool terminos = false;
  bool ocultar = true;
  bool ocultarConfirmar = true;
  String error = '';

  @override
  void dispose() {
    nombre.dispose(); correo.dispose(); clave.dispose(); confirmar.dispose();
    super.dispose();
  }

  void registrar() {
    String nuevoError = '';
    if (nombre.text.trim().isEmpty || correo.text.trim().isEmpty || clave.text.isEmpty || confirmar.text.isEmpty) {
      nuevoError = 'Completa todos los campos';
    } else if (!correoValido(correo.text)) {
      nuevoError = 'Escribe un correo válido';
    } else if (clave.text != confirmar.text) {
      nuevoError = 'Las contraseñas no coinciden';
    } else if (!terminos) {
      nuevoError = 'Debes aceptar los términos';
    }
    setState(() => error = nuevoError);
    if (nuevoError.isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen(correo: correo.text.trim())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const BackButtonSimple(),
          const SizedBox(height: 8),
          const Text('Crea tu cuenta', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: texto)),
          const Text('Completa tus datos para empezar', style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 22),
          AppInput(label: 'Nombre completo', hint: 'Juan Pérez', controller: nombre),
          const SizedBox(height: 14),
          AppInput(label: 'Correo electrónico', hint: 'tu@correo.com', controller: correo, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 14),
          AppInput(label: 'Contraseña', hint: 'Mínimo 8 caracteres', controller: clave, password: true, obscure: ocultar, onEye: () => setState(() => ocultar = !ocultar)),
          const SizedBox(height: 14),
          AppInput(label: 'Confirmar contraseña', hint: 'Repite tu contraseña', controller: confirmar, password: true, obscure: ocultarConfirmar, onEye: () => setState(() => ocultarConfirmar = !ocultarConfirmar)),
          const SizedBox(height: 8),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: terminos,
            onChanged: (valor) => setState(() => terminos = valor ?? false),
            title: const Text('Acepto los términos y condiciones y la política de privacidad', style: TextStyle(fontSize: 11)),
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
          ),
          if (error.isNotEmpty) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 11))),
          AppButton(text: 'Crear cuenta', onPressed: registrar),
          const SizedBox(height: 18),
          Center(child: Wrap(children: [
            const Text('¿Ya tienes cuenta? ', style: TextStyle(fontSize: 11, color: Colors.grey)),
            GestureDetector(onTap: () => Navigator.pop(context), child: const Text('Inicia sesión', style: TextStyle(fontSize: 11, color: Colors.deepPurple, fontWeight: FontWeight.bold))),
          ])),
        ]),
      ),
    );
  }
}
