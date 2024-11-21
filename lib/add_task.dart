import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTask> {
  final _taskController = TextEditingController();

  void _saveTask() {
    if (_taskController.text.isNotEmpty) {
      Navigator.pop(context, _taskController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tugas - My Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: 'Nama Tugas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
