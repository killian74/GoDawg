import 'package:flutter/material.dart';

class TextFieldAppBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  const TextFieldAppBar({Key? key, required this.controller, required this.hint, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
        color: Colors.deepPurpleAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.white),
                  fillColor: Colors.deepPurple,
                  filled: true,
                  prefixIcon: Icon(icon, color: Colors.white),
                  border: const OutlineInputBorder( //Outline border type for TextFeild
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
