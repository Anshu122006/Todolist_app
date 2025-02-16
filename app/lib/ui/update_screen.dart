import 'package:flutter/material.dart';
import 'package:todolist_app/Services/days.dart';
import 'package:todolist_app/components/custom_appbar.dart';
import 'package:todolist_app/components/custom_button.dart';
import 'package:todolist_app/components/custom_textfield.dart';
import 'package:todolist_app/Services/task.dart';
import 'package:todolist_app/Services/database.dart';
import 'package:todolist_app/components/pickdate.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({
    super.key,
    required this.parentHeight,
    required this.parentWidth,
    required this.id,
    required this.desc,
    required this.status,
    required this.duedate,
    required this.isDone,
  });

  final double parentWidth;
  final double parentHeight;
  final int? id;
  final String? desc;
  final String? status;
  final DateTime duedate;
  final bool isDone;
  // final DateTime? realduedate;

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController descController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController duedateController = TextEditingController();

  DateTime? duedate;

  openDatePicker() async {
    DateTime date = await PickDate.selectDate(context);
    String status = "Active";
    if (DateTime.now().isAfter(date)) {
      status = "Pending";
    }
    setState(() {
      duedate = date;
      String day = Days.values[(duedate ?? widget.duedate).weekday]
          .toString()
          .substring(5);
      duedateController.text = "${duedate.toString().split(" ")[0]}, $day";
      statusController.text = status;
    });
  }

  getButton() {
    if (!widget.isDone) {
      return Expanded(
        flex: 1,
        child: IconButton.filled(
          padding: EdgeInsets.all(5),
          onPressed: () async {
            DateTime date = await PickDate.selectDate(context);
            String status = "Active";
            if (DateTime.now().isAfter(date)) {
              status = "Pending";
            }
            setState(() {
              duedate = date;
              String day = Days.values[(duedate ?? widget.duedate).weekday]
                  .toString()
                  .substring(5);
              duedateController.text =
                  "${duedate.toString().split(" ")[0]}, $day";
              statusController.text = status;
            });
          },
          icon: Icon(Icons.calendar_today_rounded),
          iconSize: 25,
        ),
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    descController.text =
        descController.text.isEmpty ? widget.desc ?? "" : descController.text;
    if (statusController.text == "") {
      statusController.text = widget.status!;
    }
    duedate ??= widget.duedate;
    if (duedateController.text.isEmpty) {
      String day = Days.values[(duedate ?? DateTime.now()).weekday]
          .toString()
          .substring(5);
      duedateController.text = "${duedate.toString().split(" ")[0]}, $day";
    }
    return Scaffold(
      appBar: CustomAppbar(
        width: widget.parentHeight,
        title: "Modify Task",
        titlePadding: EdgeInsets.only(bottom: 10, left: 60),
        button: Container(
          margin: EdgeInsets.only(top: 30, right: 20),
          child: IconButton(
              onPressed: () {
                // Api.deleteTask(widget.id);
                DatabaseManager.deleteTask(widget.id!);
                Navigator.pop(context, true);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ),
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
                    title: "What is your next goal ?",
                    hint: "Enter Task Here",
                    readonly: widget.isDone,
                    controller: descController),
                SizedBox(height: widget.parentHeight * 0.08),
                CustomTextField(
                    title: "How is it going ?",
                    hint: "Status of this task",
                    controller: statusController,
                    readonly: true),
                SizedBox(height: widget.parentHeight * 0.08),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        flex: 6,
                        child: CustomTextField(
                          title: "Due date",
                          hint: "Enter Duedate Here",
                          controller: duedateController,
                          readonly: true,
                          onTap: () async {
                            DateTime date = await PickDate.selectDate(context);
                            String status = "Active";
                            if (DateTime.now().isAfter(date)) {
                              status = "Pending";
                            }
                            setState(() {
                              duedate = date;
                              String day = Days
                                  .values[(duedate ?? widget.duedate).weekday]
                                  .toString()
                                  .substring(5);
                              duedateController.text =
                                  "${duedate.toString().split(" ")[0]}, $day";
                              statusController.text = status;
                            });
                          },
                        )),
                    Expanded(flex: 1, child: SizedBox()),
                    getButton(),
                  ],
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                  onPressed: () {
                    if (descController.text != "") {
                      DatabaseManager.updateTask(
                          widget.id!,
                          Task(
                              desc: descController.text,
                              status: statusController.text,
                              duedate: widget.duedate));
                    }
                    Navigator.pop(context, true);
                  },
                  icon: Icons.check))
        ],
      ),
    );
  }
}
