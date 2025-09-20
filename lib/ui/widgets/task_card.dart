import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.taskStatusType, required this.color,
  });

  final String taskStatusType;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white,
      title: Text("Title will be here"),
      subtitle: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description of the task",
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            "Date: 12/12/12",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Chip(
                label: Text(taskStatusType),
                backgroundColor: color,
                labelStyle: TextStyle(
                    color: Colors.white
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
              ),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Colors.red,),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit_note), color: Colors.green,),

            ],
          ),
        ],
      ),
    );
  }
}
