import 'package:flutter/material.dart';

class TaskDetail extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final Function(String) onSaveDescription;

  const TaskDetail({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.onSaveDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController(text: taskDescription);

    return Scaffold(
      appBar: AppBar(title: Text('Detail Tugas - $taskName')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Tugas: $taskName',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Deskripsi:', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tambahkan deskripsi tugas di sini...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onSaveDescription(_descriptionController.text);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
