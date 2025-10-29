import 'package:flutter/material.dart';
import 'package:task_manager2/data/services/api_caller.dart';
import 'package:task_manager2/data/utils/urls.dart';
import 'package:task_manager2/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager2/ui/widgets/screen_%20background.dart';
import 'package:task_manager2/ui/widgets/snack_bar_message.dart';
import 'package:task_manager2/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _titleTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Title"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a valid title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: InputDecoration(hintText: "Description"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress ==false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapAddTaskButton,
                      child: Text("Add Task"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddTaskButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  //API call
  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };
    final ApiResponse response = await ApiCaller.postRequest(
      url: urls.createTaskUrl,
      body: requestBody,
    );
    _addNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess) {
      clearFields();
      showSnackBarMessage(context, "New task has been added");
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void clearFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
