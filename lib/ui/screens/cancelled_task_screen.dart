import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:task_manager/ui/controllers/cancelled_task_controller.dart';
import 'package:task_manager/widget/centered_circular_progress_indicator.dart';


import '../../widget/snack_bar_message.dart';
import '../../widget/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController = Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CancelledTaskController>(
      builder: (controller) {
        return Visibility(
          visible: !controller.inProgress,
          replacement: const CenteredCircularProgressIndicator(),
          child: RefreshIndicator(
            onRefresh: _getCancelledTaskList,
            child: ListView.separated(
              itemCount: controller.cancelledTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskModel: controller.cancelledTaskList[index],
                  onRefreshList: _getCancelledTaskList,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ),
        );
      }
    );
  }

  Future<void> _getCancelledTaskList() async {
   final bool result = await _cancelledTaskController.getCancelledTaskList();
    if (result) {
      showSnackBarMessage(context, _cancelledTaskController.errorMessage!, true);
    }
  }
}
