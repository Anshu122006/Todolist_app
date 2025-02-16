import 'package:flutter/material.dart';
import 'package:todolist_app/Services/days.dart';
import 'package:todolist_app/components/custom_appbar.dart';
import 'package:todolist_app/components/custom_textfield.dart';
import 'package:todolist_app/Services/task.dart';
// import 'package:todolist_app/Services/api.dart';
import 'package:todolist_app/Services/database.dart';
import 'package:todolist_app/components/pickdate.dart';

class AddTask extends StatefulWidget {
  const AddTask(
      {super.key, required this.parentHeight, required this.parentWidth});

  final double parentWidth;
  final double parentHeight;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController descController = TextEditingController();
  // TextEditingController status = TextEditingController();
  TextEditingController duedateController = TextEditingController();
  DateTime duedate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        width: widget.parentWidth,
        title: "New Task",
        titlePadding: EdgeInsets.only(bottom: 10, left: 60),
      ),
      body: Stack(
        children: [
          Container(
            height: widget.parentHeight,
            width: widget.parentWidth,
            padding: EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 2, 62, 125),
                  const Color.fromARGB(255, 0, 32, 68),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    title: "What is your next goal",
                    hint: "Enter Task Here",
                    controller: descController),
                SizedBox(height: widget.parentHeight * 0.08),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomTextField(
                        title: "Due date",
                        hint: "Select a Duedate",
                        readonly: true,
                        controller: duedateController,
                        onTap: () async {
                          DateTime date = await PickDate.selectDate(context);
                          setState(() {
                            duedate = date;
                            String day = Days.values[duedate.weekday]
                                .toString()
                                .substring(5);
                            duedateController.text =
                                "${date.toString().split(" ")[0]}, $day";
                          });
                        },
                      ),
                    ),
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: IconButton.filled(
                        padding: EdgeInsets.all(5),
                        onPressed: () async {
                          DateTime date = await PickDate.selectDate(context);
                          setState(() {
                            duedate = date;
                            String day = Days.values[duedate.weekday]
                                .toString()
                                .substring(5);
                            duedateController.text =
                                "${date.toString().split(" ")[0]}, $day";
                          });
                        },
                        icon: Icon(Icons.calendar_today_rounded),
                        iconSize: 25,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 30, right: 15),
              child: ElevatedButton(
                onPressed: () {
                  String status = "Active";
                  if (DateTime.now().isAfter(duedate)) {
                    status = "Pending";
                  }

                  if (descController.text != "") {
                    DatabaseManager.addTask(Task(
                        desc: descController.text,
                        status: status,
                        duedate: duedate,
                        dueday: Days.values[duedate.weekday].toString()));
                  }
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 15,
                  shadowColor: const Color.fromARGB(255, 52, 52, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(15),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: Icon(Icons.check,
                    size: 30, color: const Color.fromARGB(255, 29, 49, 79)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
