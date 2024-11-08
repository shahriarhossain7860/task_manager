import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/progress_task_controller.dart';
import 'package:task_manager/widget/centered_circular_progress_indicator.dart';

import '../../widget/snack_bar_message.dart';
import '../../widget/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(builder: (contriller) {
      return Visibility(
        visible: !contriller.inProgress,
        replacement: const CenteredCircularProgressIndicator(),
        child: RefreshIndicator(
          onRefresh: _getProgressTaskList,
          child: ListView.separated(
            itemCount: contriller.progressTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                taskModel: contriller.progressTaskList[index],
                onRefreshList: _getProgressTaskList,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
          ),
        ),
      );
    });
  }

  Future<void> _getProgressTaskList() async {
    final bool result = await _progressTaskController.getProgressTaskList();
    if (result) {
      showSnackBarMessage(context, _progressTaskController.errorMessage!, true);
    }
  }
}
