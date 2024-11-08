import 'package:get/get.dart';
import 'package:task_manager/data/models/task_model.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListController extends GetxController{
  List<TaskModel> _taskList = [];
  bool _inProgress = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool get inProgress => _inProgress;
  List<TaskModel> get taskList => _taskList;
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.newTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _taskList = taskListModel.taskList ?? [];
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}