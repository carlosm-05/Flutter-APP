import 'package:flutter/material.dart';

const Color morado = Color(0xFF8A35F0);
const Color rosado = Color(0xFFE83EAA);
const Color texto = Color(0xFF17172A);

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool password;
  final bool obscure;
  final VoidCallback? onEye;
  final TextInputType keyboardType;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.password = false,
    this.obscure = false,
    this.onEye,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: texto)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: password && obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE8E7F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE8E7F0)),
            ),
            suffixIcon: password
                ? IconButton(
                    onPressed: onEye,
                    icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, size: 18),
                    style: IconButton.styleFrom(fixedSize: const Size(50, 50)),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool secondary;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: secondary ? null : const LinearGradient(colors: [morado, rosado]),
          color: secondary ? Colors.white : null,
          borderRadius: BorderRadius.circular(10),
          boxShadow: secondary
              ? []
              : [BoxShadow(color: rosado.withOpacity(0.18), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.grey.shade300,
            shadowColor: Colors.transparent,
            foregroundColor: secondary ? texto : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class BackButtonSimple extends StatelessWidget {
  const BackButtonSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.chevron_left),
        style: IconButton.styleFrom(backgroundColor: Colors.white, fixedSize: const Size(50, 50)),
      ),
    );
  }
}

class DecoratedPage extends StatelessWidget {
  final Widget child;
  const DecoratedPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: -60, right: -35, child: _circle(190, const [Color(0xFF9C4BE7), Color(0xFFEF42AA)])),
          Positioned(bottom: -32, left: -28, child: _circle(100, const [Color(0xFFB9D9FF), Color(0xFFC7DFFF)])),
          Positioned(bottom: 18, right: -12, child: Transform.rotate(angle: -0.3, child: Container(width: 26, height: 34, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFFFC12D), Color(0xFFFF7C28)]), borderRadius: BorderRadius.circular(8))))),
          SafeArea(child: child),
        ],
      ),
    );
  }

  Widget _circle(double size, List<Color> colors) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
    );
  }
}

bool correoValido(String correo) {
  return RegExp(r'^[\w\.-]+@[\w\.-]+\.[A-Za-z]{2,}$').hasMatch(correo.trim());
}
