class Task {
  String? objectId;
  final String title;
  final DateTime dueDate;  // Added dueDate field
  bool status;

  Task({
    this.objectId,
    required this.title,
    required this.dueDate,  // Include dueDate in constructor
    this.status = false,
  });

  // Convert a Task instance to JSON (including dueDate)
  Map<String, dynamic> toJson() => {
    'id': objectId,
    'title': title,
    'dueDate': dueDate,  // Convert DateTime to string format
    'status': status,
  };

  // Convert a Map to a Task instance (including dueDate)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      objectId: json['objectId'] as String?,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['dueDate']),  // Parse DateTime string back to DateTime
      status: json['status'] as bool,
    );
  }

  // Method to toggle the task status
  void toggleStatus() {
    status = !status;
  }
}
