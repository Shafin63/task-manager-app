import 'package:flutter/material.dart';
import 'package:task_manager2/data/models/task_model.dart';
import 'package:task_manager2/data/models/task_status_count_model.dart';
import 'package:task_manager2/data/services/api_caller.dart';
import 'package:task_manager2/data/utils/urls.dart';
import 'package:task_manager2/ui/screens/add_new_task_screen.dart';
import 'package:task_manager2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager2/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  bool _getNewTaskInProgress = false;
  List<taskStatusCountModel> _taskStatusCountList = [];
  List<TaskModel> _newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    _getAllNewTasks();
  }

  Future<void> _getAllTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<taskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData["data"]) {
        list.add(taskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      return showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

  Future<void> _getAllNewTasks() async {
    _getNewTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: urls.newTasklistUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> newTasklist = [];
      for (Map<String, dynamic> jsonData in response.responseData["data"]) {
        newTasklist.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = newTasklist;
    } else {
      return showSnackBarMessage(context, response.errorMessage!);
    }
    _getNewTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 16),
            SizedBox(
              height: 90,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountByStatusCard(
                      title: _taskStatusCountList[index].status,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 6);
                  },
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: _getNewTaskInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskCard(
                      // taskStatusType: 'New',
                      // color: Colors.blue,
                      taskModel: _newTaskList[index], refreshParent: () {
                        _getAllNewTasks();
                    },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: _newTaskList.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }
}
