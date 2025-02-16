import 'package:flutter/material.dart';
import 'package:todolist_app/components/custom_appbar.dart';
import 'package:todolist_app/components/custom_button.dart';
import 'package:todolist_app/Services/task.dart';
import 'package:todolist_app/Services/database.dart';
import 'package:todolist_app/ui/add_screen.dart';
import 'package:todolist_app/components/tasklist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppbar(
        width: width,
        title: "Your Goals !",
        titlePadding: EdgeInsets.only(bottom: 10, left: 30),
      ),
      body: FutureBuilder(
          // future: Api.getAllTasks(),
          future: DatabaseManager.getTaskList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Task> taskList = snapshot.data;

              return Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
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
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Expanded(
                          child: TaskList(
                            taskList: taskList,
                            parentHeight: height,
                            parentWidth: width,
                            onDelete: () {
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTask(
                                      parentHeight: height,
                                      parentWidth: width)),
                            ).then((value) =>
                                {if (value == true) setState(() {})});
                          },
                          icon: Icons.add))
                ],
              );
            }
          }),
    );
  }
}
