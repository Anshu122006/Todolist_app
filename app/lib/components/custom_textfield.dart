import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool readonly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.readonly = false,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
              color: const Color.fromARGB(255, 112, 194, 232),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        TextField(
          onTap: widget.onTap ?? () {},
          controller: widget.controller,
          readOnly: widget.readonly,
          showCursor: true,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: const Color.fromARGB(255, 208, 208, 208),
                fontStyle: FontStyle.italic),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: const Color.fromARGB(255, 91, 150, 198), width: 1),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: const Color.fromARGB(255, 35, 127, 202),
                  width: 2), // When focused
            ),
          ),
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }
}
