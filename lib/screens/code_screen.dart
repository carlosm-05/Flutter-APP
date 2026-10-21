import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets.dart';
import 'new_password_screen.dart';

class CodeScreen extends StatefulWidget {
  final String correo;
  const CodeScreen({super.key, required this.correo});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final cajas = List.generate(4, (_) => TextEditingController());
  final focos = List.generate(4, (_) => FocusNode());
  int segundos = 45;
  Timer? reloj;
  String error = '';

  @override
  void initState() { super.initState(); iniciarReloj(); }

  void iniciarReloj() {
    reloj?.cancel();
    setState(() => segundos = 45);
    reloj = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (segundos <= 1) {
        timer.cancel();
        setState(() => segundos = 0);
      } else {
        setState(() => segundos--);
      }
    });
  }

  @override
  void dispose() {
    reloj?.cancel();
    for (final c in cajas) { c.dispose(); }
    for (final f in focos) { f.dispose(); }
    super.dispose();
  }

  void continuar() {
    final codigo = cajas.map((c) => c.text).join();
    if (codigo.length != 4) {
      setState(() => error = 'Escribe los cuatro dígitos');
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => NewPasswordScreen(correo: widget.correo)));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedPage(child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const BackButtonSimple(),
        const SizedBox(height: 18),
        Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.verified_user_outlined, color: Colors.white)),
        const SizedBox(height: 18),
        const Text('Verifica tu correo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: texto)),
        const SizedBox(height: 8),
        Text('Escribe el código de 4 dígitos que enviamos a ${widget.correo}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 28),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(4, (i) => SizedBox(
          width: 55, height: 55,
          child: TextField(
            controller: cajas[i], focusNode: focos[i],
            textAlign: TextAlign.center, keyboardType: TextInputType.number, maxLength: 1,
            onChanged: (valor) {
              if (valor.isNotEmpty) {
                cajas[i].text = valor.replaceAll(RegExp(r'[^0-9]'), '');
                if (i < 3) focos[i + 1].requestFocus();
              } else if (i > 0) {
                focos[i - 1].requestFocus();
              }
              setState(() {});
            },
            decoration: InputDecoration(counterText: '', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          ),
        ))),
        const SizedBox(height: 12),
        if (error.isNotEmpty) Text(error, style: const TextStyle(color: Colors.red, fontSize: 11)),
        Center(child: Text(segundos > 0 ? 'Reenviar código en 00:${segundos.toString().padLeft(2, '0')}' : 'Ya puedes reenviar el código', style: const TextStyle(fontSize: 11, color: Colors.deepPurple))),
        if (segundos == 0) Center(child: TextButton(onPressed: iniciarReloj, style: TextButton.styleFrom(minimumSize: const Size(0, 42)), child: const Text('Reenviar código'))),
        const SizedBox(height: 18),
        AppButton(text: 'Siguiente', onPressed: continuar),
      ]),
    ));
  }
}
