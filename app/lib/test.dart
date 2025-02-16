// import 'package:flutter/material.dart';
// import 'package:todolist_app/models/task.dart';
// import 'package:todolist_app/Services/database.dart';

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   DatabaseManager.addTask(Task(
//                       desc: "adasd",
//                       status: "hfiewoww",
//                       duedate: "uiefgikefhkjsd"));
//                 },
//                 child: Text("AddButton")),
//             ElevatedButton(
//                 onPressed: () {
//                   DatabaseManager.getTaskList();
//                 },
//                 child: Text("GetButton")),
//             ElevatedButton(
//                 onPressed: () {
//                   DatabaseManager.deleteDB();
//                 },
//                 child: Text("DeleteDBButton")),
//           ],
//         ),
//       ),
//     );
//   }
// }
