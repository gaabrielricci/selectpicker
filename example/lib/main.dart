import 'package:flutter/material.dart';
import 'package:selectpicker/selectpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SelectPicker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SelectPickerExample(),
    );
  }
}

class SelectPickerExample extends StatefulWidget {
  const SelectPickerExample({super.key});

  @override
  State<SelectPickerExample> createState() => _SelectPickerExampleState();
}

class _SelectPickerExampleState extends State<SelectPickerExample> {
  String? _selectedFruit;
  User? _selectedUser;
  bool _isLoading = false;

  final List<String> _fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry', 'Médico', 'São Paulo'];
  final List<User> _users = [
    User(id: 1, name: 'Gabriel Ricci'),
    User(id: 2, name: 'John Doe'),
    User(id: 3, name: 'Jane Smith'),
    User(id: 4, name: 'Aclécio Médico'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectPickerNew Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simple String Selection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Simulate Loading State'),
              value: _isLoading,
              onChanged: (value) => setState(() => _isLoading = value),
            ),
            const SizedBox(height: 12),
            SelectPickerNew<String>(
              items: _fruits,
              initialValue: _selectedFruit,
              hint: 'Select a fruit',
              searchHint: 'Search fruits...',
              isLoading: _isLoading,
              loadingMessage: 'Loading fruits...',
              onChanged: (value) {
                setState(() {
                  _selectedFruit = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Complex Object Selection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SelectPickerNew<User>(
              items: _users,
              initialValue: _selectedUser,
              hint: 'Select a user',
              titleBuilder: (user) => user.name,
              onChanged: (value) {
                setState(() {
                  _selectedUser = value;
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_selectedFruit != null || _selectedUser != null)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selection Result:', style: TextStyle(fontWeight: FontWeight.bold)),
                      if (_selectedFruit != null) Text('Fruit: $_selectedFruit'),
                      if (_selectedUser != null) Text('User: ${_selectedUser?.name} (ID: ${_selectedUser?.id})'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}
