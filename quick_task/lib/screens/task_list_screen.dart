import 'package:flutter/material.dart';
import 'add_task_screen.dart';  // Import AddTaskScreen
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'login_screen.dart';  // Import your LoginScreen

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _taskController = TaskController();
  late Future<List<Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = _taskController.getTasks();  // Load tasks from backend
  }

  void _toggleTaskStatus(Task task) async {
    task.status = !task.status;  // Toggle completion status
    await _taskController.updateTaskStatus(task);
    setState(() {
      _tasks = _taskController.getTasks();  // Refresh task list
    });
  }

  void _deleteTask(String objectId) async {
    await _taskController.deleteTask(objectId);  // Delete task by objectId
    setState(() {
      _tasks = _taskController.getTasks();  // Refresh task list
    });
  }

  void _exitToLogin() {
    // Navigate to the LoginScreen and replace the current screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),  // Replace with your LoginScreen widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List',
        style: TextStyle(fontSize: 30)),
        backgroundColor: Colors.deepPurple,  // Set AppBar color to purple
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tasks = snapshot.data!;

          if (tasks.isEmpty) {
            return Center(child: Text('No tasks available.'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.status ? TextDecoration.lineThrough : null,
                    color: task.status ? Colors.grey : Colors.black,
                  ),
                ),
                subtitle: task.dueDate != null
                    ? Text(
                  'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}',  // Show the date in a readable format
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                )
                    : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        task.status ? Icons.check_circle : Icons.circle,
                        color: task.status ? Colors.green : Colors.grey,  // Set color to purple when unchecked
                      ),
                      onPressed: () => _toggleTaskStatus(task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(task.objectId!),  // Safe usage of objectId
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Stack(
        children: [
          // Add Task Button (Floating Action Button)
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddTaskScreen()),
                ).then((value) {
                  setState(() {
                    _tasks = _taskController.getTasks();  // Refresh task list after adding
                  });
                });
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.deepPurple,  // Set FAB color to purple
            ),
          ),
          // Exit Button (Floating Action Button)
          Positioned(
            bottom: 20,
            left: 40,
            child: FloatingActionButton(
              onPressed: _exitToLogin,  // Navigate to the login screen
              child: Icon(Icons.exit_to_app),
              backgroundColor: Colors.deepPurple,  // Set FAB color to purple
            ),
          ),
        ],
      ),
    );
  }
}
