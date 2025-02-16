import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CustomButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, right: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 15,
          shadowColor: const Color.fromARGB(255, 52, 52, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.all(15),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
        child:
            Icon(icon, size: 30, color: const Color.fromARGB(255, 29, 49, 79)),
      ),
    );
  }
}
