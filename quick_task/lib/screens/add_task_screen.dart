import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = TaskController();
  final TextEditingController _titleController = TextEditingController();
  DateTime? _dueDate;  // To store the selected due date

  // Function to pick a date from the calendar
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != _dueDate) {
      setState(() {
        _dueDate = selectedDate;
      });
    }
  }

  // Function to save the task
  void _saveTask() async {
    if (_titleController.text.isNotEmpty && _dueDate != null) {
      final task = Task(
        title: _titleController.text,
        dueDate: _dueDate ?? DateTime.now(),  // Store the due date
      );
      await _taskController.addTask(task);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title and select a due date.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Task title input
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 20),

            // Due date picker
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 10),
                Text(
                  _dueDate == null
                      ? 'Select Due Date'
                      : 'Due Date: ${_dueDate!.toLocal()}'.split(' ')[0], // Show selected date
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _selectDueDate(context),  // Trigger the calendar
                  child: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Save task button
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
