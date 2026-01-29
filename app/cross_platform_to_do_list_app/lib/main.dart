import 'package:flutter/material.dart';

void main() {
  runApp(CrossPlatformTodoApp());
}

class CrossPlatformTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cross-Platform To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF2F2F2),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> tasks = [];
  final TextEditingController taskController = TextEditingController();

  // Add a new task
  void addTask() {
    if (taskController.text.trim().isEmpty) return;
    setState(() {
      tasks.add(taskController.text.trim());
      taskController.clear();
    });

    // Show success SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task added successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Remove a task at index
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    // Show success SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task deleted successfully!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cross-Platform To-Do List App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 61, 233, 55),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field with shadow and rounded corners
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: taskController,
                      decoration: InputDecoration(
                        hintText: 'Enter a new task',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => addTask(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: addTask,
                      child: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16),
                        backgroundColor: const Color.fromARGB(255, 106, 242, 43),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Task list with cards and design
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                      child: Text(
                        'No tasks yet. Add a task!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Text(
                              tasks[index],
                              style: TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => removeTask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}