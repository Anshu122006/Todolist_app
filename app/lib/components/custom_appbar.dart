import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // Required for PreferredSizeWidget

  final double width;
  final String title;
  final EdgeInsetsGeometry titlePadding;
  final Color iconColor;
  final Color gradientOne;
  final Color gradientTwo;
  final Widget? button;

  const CustomAppbar({
    super.key,
    required this.width,
    required this.title,
    required this.titlePadding,
    this.iconColor = const Color.fromARGB(255, 255, 255, 255),
    this.gradientOne = const Color.fromARGB(255, 0, 150, 199),
    this.gradientTwo = const Color.fromARGB(255, 0, 119, 182),
    this.button,
  })  : preferredSize = const Size.fromHeight(56.0),
        super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: iconColor),
      flexibleSpace: Container(
        width: width,
        padding: titlePadding,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(186, 45, 45, 45),
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(0, 1),
            )
          ],
          gradient: LinearGradient(
            colors: [
              gradientOne,
              gradientTwo,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              button ?? SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
