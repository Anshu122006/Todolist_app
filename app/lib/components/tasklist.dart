import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_app/Services/database.dart';
import 'package:todolist_app/Services/days.dart';
import 'package:todolist_app/Services/task.dart';
import 'package:todolist_app/ui/update_screen.dart';

//-----------------------------------TaskList-----------------------------------

class TaskList extends StatelessWidget {
  const TaskList(
      {super.key,
      required this.taskList,
      required this.parentHeight,
      required this.parentWidth,
      required this.onDelete});

  final double parentWidth;
  final double parentHeight;
  final Function onDelete;

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskTile(
          parentHeight: parentHeight,
          parentWidth: parentWidth,
          desc: taskList[index].desc!,
          status: taskList[index].status!,
          duedate: taskList[index].duedate!,
          id: taskList[index].id!,
          onDelete: onDelete,
        );
      },
    );
  }
}

//-----------------------------------TaskTile-----------------------------------

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.parentHeight,
    required this.parentWidth,
    required this.desc,
    required this.status,
    required this.duedate,
    required this.id,
    required this.onDelete,
  });

  final double parentWidth;
  final double parentHeight;
  final String desc;
  final String status;
  final DateTime duedate;
  final int id;
  final Function onDelete;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isDone = false;
  Color gradientOne = const Color.fromARGB(255, 0, 93, 155);
  Color gradientTwo = const Color.fromARGB(255, 0, 108, 184);

  onDone() {
    setState(() {
      if (!isDone) {
        gradientOne = const Color.fromARGB(255, 6, 43, 68);
        gradientTwo = const Color.fromARGB(255, 14, 64, 100);
        DatabaseManager.updateTask(
            widget.id,
            Task(
              desc: widget.desc,
              status: "Done",
              duedate: widget.duedate,
            ));
        isDone = true;
      }
    });
    widget.onDelete();
  }

  _getStatusColor() {
    if (widget.status == "Done") {
      return Colors.lightGreen;
    } else if (widget.status == "Pending") {
      return Colors.red;
    } else {
      return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String status = "";
        if (isDone) {
          status = "Done";
        } else if (DateTime.now().isAfter(widget.duedate)) {
          status = "Pending";
        } else {
          status = "Active";
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateTask(
                      parentHeight: widget.parentHeight,
                      parentWidth: widget.parentWidth,
                      id: widget.id,
                      desc: widget.desc,
                      status: status,
                      duedate: widget.duedate,
                      isDone: isDone,
                    ))).then((value) => {if (value == true) widget.onDelete()});
      },
      child: Container(
        width: widget.parentWidth,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradientOne,
              gradientTwo,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: TaskCheckbox(onDone: onDone)),
            Expanded(
              flex: 20,
              child: Column(
                children: [
                  Container(
                    width: widget.parentWidth * 0.8,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      widget.desc,
                      style: GoogleFonts.robotoMono(
                          color: const Color.fromARGB(255, 203, 203, 203),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: widget.parentWidth * 0.8,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Text(
                                "Status: ",
                                style: GoogleFonts.robotoMono(
                                    color: const Color.fromARGB(255, 203, 203,
                                        203), //_getStatusColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.status,
                                style: GoogleFonts.robotoMono(
                                    color: _getStatusColor(),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${widget.duedate.toString().split(" ")[0]}, ${Days.values[widget.duedate.weekday].toString().substring(5)}",
                            style: GoogleFonts.robotoMono(
                                color: const Color.fromARGB(255, 199, 199, 199),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//-----------------------------------Checkbox-----------------------------------

class TaskCheckbox extends StatefulWidget {
  final Function onDone;
  const TaskCheckbox({super.key, required this.onDone});

  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            if (!isChecked) {
              isChecked = true;
              widget.onDone();
            }
          });
        },
        activeColor: Colors.green,
        checkColor: Colors.blueGrey[100],
      ),
    );
  }
}
