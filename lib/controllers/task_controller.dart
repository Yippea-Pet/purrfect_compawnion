import 'package:get/get.dart';
import 'package:purrfect_compawnion/db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController{

  // final user = Provider.of<MyUser>(context);

  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    // return await DatabaseService(user: user.uid).addTask(task);
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    var val = DBHelper.delete(task);
    print(val);
  }
}