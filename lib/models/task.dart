import 'package:intl/intl.dart';

class Task {
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  int? difficulty;

  Task({
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.difficulty,
  });

  DateTime getDate() {
    return DateFormat('MM/dd/yyyy').parse(date!);
  }

  DateTime getRemindTime() {
    DateTime taskStart = DateFormat.jm().parse(startTime!);
    DateTime taskRemind = DateFormat('MM/dd/yyyy')
        .parse(date!)
        .add(Duration(hours: taskStart.hour, minutes: taskStart.minute))
        .subtract(Duration(minutes: remind!));
    return taskRemind;
  }

  DateTime getEndTime() {
    String taskEndTime =
        DateFormat("HH:mm").format(DateFormat.jm().parse(endTime!));
    int endHour = int.parse(taskEndTime.split(":")[0]);
    int endMinute = int.parse(taskEndTime.split(":")[1]);
    DateTime taskEnd = DateFormat('MM/dd/yyyy')
        .parse(date!)
        .add(Duration(hours: endHour, minutes: endMinute));
    return taskEnd;
  }
}
