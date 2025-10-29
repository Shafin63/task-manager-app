class taskStatusCountModel {
  final String status;
  final int count;

  taskStatusCountModel({required this.status, required this.count});

  factory taskStatusCountModel.fromJson(Map<String, dynamic> jsonData) {
    return taskStatusCountModel(
      status: jsonData["_id"],
      count: jsonData["sum"],
    );
  }
}
