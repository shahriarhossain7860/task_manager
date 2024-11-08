import 'package:flutter/material.dart';
import 'package:task_manager/widget/centered_circular_progress_indicator.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../../widget/snack_bar_message.dart';
import '../../widget/task_card.dart';
class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListIndicator = false;
  List<TaskModel> progressTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getProgressTaskListIndicator,
      replacement: const CenteredCircularProgressIndicator() ,
      child: RefreshIndicator(
        onRefresh: _getProgressTaskList,
        child: ListView.separated(
          itemCount: progressTaskList.length,
          itemBuilder: (context, index) {
             return  TaskCard(
               taskModel: progressTaskList[index],
               onRefreshList: _getProgressTaskList,
             );

          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }
  Future<void> _getProgressTaskList() async {
    progressTaskList.clear();
    _getProgressTaskListIndicator = true;
    setState(() {});
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.ProgressTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
      progressTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getProgressTaskListIndicator = false;
    setState(() {});
  }
}
