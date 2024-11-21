import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../models/task.dart';

class TaskController {
  // Add a new task to Back4App
  Future<void> addTask(Task task) async {
    final taskObject = ParseObject('Task')
      ..set('title', task.title)
      ..set('status', task.status)
      ..set('dueDate', task.dueDate);  // Add dueDate field
    final response = await taskObject.save();
    if (!response.success) {
      throw Exception('Failed to add task: ${response.error?.message}');
    }
  }

  // Fetch all tasks from Back4App
  Future<List<Task>> getTasks() async {
    final query = QueryBuilder(ParseObject('Task'));
    final response = await query.query();
    if (response.success && response.results != null) {
      return response.results!.map((e) {
        final parseObject = e as ParseObject;
        return Task(
          objectId: parseObject.objectId,
          title: parseObject.get<String>('title') ?? 'Untitled',
          status: parseObject.get<bool>('status') ?? false,
          dueDate: parseObject.get<DateTime>('dueDate') ?? DateTime.now(),
        );
      }).toList();
    } else {
      return [];
    }
  }

  // Toggle task status in Back4App
  Future<void> toggleTaskStatus(Task task) async {
    if (task.objectId == null) {
      throw Exception('Task ID cannot be null');
    }
    final taskObject = ParseObject('Task')
      ..objectId = task.objectId
      ..set('status', task.status);
    final response = await taskObject.save();
    if (!response.success) {
      throw Exception('Failed to update task status: ${response.error?.message}');
    }
  }

  // Update task status (true/false) on the backend
  Future<void> updateTaskStatus(Task task) async {
    final parseObject = ParseObject('Task')..objectId = task.objectId;
    parseObject.set('status', task.status);  // Set the new status

    final response = await parseObject.save();

    if (!response.success) {
      throw Exception('Failed to update task status');
    }
  }

  // Delete a task in Back4App
  Future<void> deleteTask(String objectId) async {
    final taskObject = ParseObject('Task')..objectId = objectId;
    final response = await taskObject.delete();
    if (!response.success) {
      throw Exception('Failed to delete task: ${response.error?.message}');
    }
  }
}
