class Task {
  Task({this.id, this.status, this.duedate, this.desc, this.dueday});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      desc: json['desc'],
      status: json['status'],
      duedate: DateTime.parse(json['duedate']),
      dueday: json['dueday'],
    );
  }
  int? id;
  String? status;
  DateTime? duedate;
  String? dueday;
  String? desc;

  Map<String, dynamic> toMap() {
    return {
      "desc": desc,
      "status": status,
      "duedate": duedate.toString().split(" ")[0],
      "dueday": dueday
    };
  }
}
