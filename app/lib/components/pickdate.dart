import 'package:flutter/material.dart';

class PickDate {
  static Future<DateTime> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 70, 100, 183),
              onPrimary: const Color.fromARGB(
                  255, 77, 77, 77),
              surface: const Color.fromARGB(
                  255, 185, 210, 253),
              onSurface: const Color.fromARGB(
                  255, 90, 90, 90),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 120, bottom: 120),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 185, 210, 253),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(2, 2)),
              ],
            ),
            child: child!,
          ),
        );
      },
    );

    return pickedDate ?? DateTime.now();
  }
}
