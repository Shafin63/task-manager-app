import 'package:flutter/material.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return TaskCard(taskStatusType: 'Completed', color: Colors.green,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
