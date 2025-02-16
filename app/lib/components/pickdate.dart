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
            // Background color of the calendar
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 70, 100, 183), // Main color
              onPrimary: const Color.fromARGB(
                  255, 77, 77, 77), // Text color on buttons
              surface: const Color.fromARGB(
                  255, 185, 210, 253), // Calendar background
              onSurface: const Color.fromARGB(
                  255, 90, 90, 90), // Text color inside the calendar
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
              // border: Border.all(color: Colors.amber, width: 2)
            ),
            child: child!,
          ),
        );
      },
    );

    return pickedDate ?? DateTime.now();
  }
}
