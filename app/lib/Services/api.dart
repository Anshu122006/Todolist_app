// ignore_for_file: avoid_print

import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todolist_app/Services/task.dart';

class Api {
  static const String baseUrl = "http://10.17.5.94:2000/api/";

//add method
  static addTask(Map tdata) async {
    var url = Uri.parse("${baseUrl}add_task");

    try {
      var res = await http.post(url, body: tdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
        // Task task = Task(
        //     id: data._id,
        //     title: data.title,
        //     status: data.status,
        //     importance: data.importance,
        //     duedate: data.duedate,
        //     desc: data.desc);
        // return task;
      } else {
        print("failed to add task");
      }
    } catch (e) {
      print(e);
    }
  }

  // get method
  static getTask(id) async {
    var url = Uri.parse("${baseUrl}get_task/$id");
    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);

        Task task = Task(
            id: data._id,
            status: data.status,
            duedate: data.duedate,
            desc: data.desc);
        return task;
      } else {
        print("failed to get task");
      }
    } catch (e) {
      print(e);
    }
  }

  // get all method
  static Future<List<Task>?> getAllTasks() async {
    var url = Uri.parse("${baseUrl}get_alltasks");
    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(res.body);

        List<Task> taskList =
            jsonList.map((json) => Task.fromJson(json)).toList();

        return taskList;
      } else {
        print("failed to get task");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  // update method
  static updateTask(id, newData) async {
    var url = Uri.parse("${baseUrl}update_task/$id");

    try {
      var res = await http.patch(url, body: newData);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("failed to update task");
      }
    } catch (e) {
      print(e);
    }
  }

  // delete method
  static deleteTask(id) async {
    var url = Uri.parse("${baseUrl}delete_task/$id");

    try {
      var res = await http.delete(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("failed to delete task");
      }
    } catch (e) {
      print(e);
    }
  }
}
