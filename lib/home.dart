import 'package:flutter/material.dart';
import 'add_task.dart';
import 'task_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> tasks = [
    {"name": "Tugas 1", "description": ""},
    {"name": "Tugas 2", "description": ""},
    {"name": "Tugas 3", "description": ""},
  ];
  int _currentView = 0; // 0 untuk List, 1 untuk Grid

  void _addTask(String task) {
    setState(() {
      tasks.add({"name": task, "description": ""});
    });
  }

  void _renameTask(int index, String newName) {
    setState(() {
      tasks[index]["name"] = newName;
    });
  }

  void _editDescription(int index, String description) {
    setState(() {
      tasks[index]["description"] = description;
    });
  }

  void _showRenameDialog(int index) {
    final _renameController =
        TextEditingController(text: tasks[index]["name"]);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Tugas'),
          content: TextField(
            controller: _renameController,
            decoration: const InputDecoration(labelText: 'Nama Tugas Baru'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (_renameController.text.isNotEmpty) {
                  _renameTask(index, _renameController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100, // Sesuaikan dengan warna halaman login
      appBar: AppBar(
        title: const Text('My Task - Daftar Tugas'),
        backgroundColor: Colors.blue, // Sesuaikan dengan warna yang konsisten
      ),
      body: _currentView == 0
          ? ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(tasks[index]["name"]!),
                    subtitle: Text(
                      tasks[index]["description"]!.isEmpty
                          ? "Deskripsi belum diisi"
                          : tasks[index]["description"]!,
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == "rename") {
                          _showRenameDialog(index);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "rename",
                          child: Text("Rename"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetail(
                            taskName: tasks[index]["name"]!,
                            taskDescription: tasks[index]["description"]!,
                            onSaveDescription: (newDescription) =>
                                _editDescription(index, newDescription),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetail(
                          taskName: tasks[index]["name"]!,
                          taskDescription: tasks[index]["description"]!,
                          onSaveDescription: (newDescription) =>
                              _editDescription(index, newDescription),
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            tasks[index]["name"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == "rename") {
                                _showRenameDialog(index);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "rename",
                                child: Text("Rename"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentView,
        onTap: (index) {
          setState(() {
            _currentView = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Grid',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTask()),
          );
          if (newTask != null) _addTask(newTask);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
