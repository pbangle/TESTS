import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RandomizerApp());
}

class RandomizerApp extends StatelessWidget {
  const RandomizerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomizerHomePage(),
    );
  }
}

class RandomizerHomePage extends StatefulWidget {
  const RandomizerHomePage({Key? key}) : super(key: key);

  @override
  _RandomizerHomePageState createState() => _RandomizerHomePageState();
}

class _RandomizerHomePageState extends State<RandomizerHomePage> {
  final List<String> _names = [];
  final TextEditingController _nameController = TextEditingController();
  String _selectedName = '';

  void _addName() {
    final enteredName = _nameController.text.trim();
    if (enteredName.isNotEmpty) {
      setState(() {
        _names.add(enteredName);
        _nameController.clear();
      });
    }
  }

  void _randomizeName() {
    if (_names.isNotEmpty) {
      final randomIndex = Random().nextInt(_names.length);
      setState(() {
        _selectedName = _names[randomIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomizer'),
      ),
      backgroundColor: const Color(0xFF404040),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNameTextField(),
              const SizedBox(height: 10),
              _buildActionButtons(),
              const SizedBox(height: 20),
              const Text(
                'Randomly Selected Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                _selectedName,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _names.length,
                  itemBuilder: (context, index) => _buildNameCard(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Enter a name',
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _addName,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            backgroundColor: const Color(0xFFFF681F),
          ),
          child: const Text('Add Name'),
        ),
        ElevatedButton(
          onPressed: _randomizeName,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
            backgroundColor: const Color(0xFFFF681F),
          ),
          child: const Text('Randomize'),
        ),
      ],
    );
  }

  Widget _buildNameCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
      child: ListTile(
        title: Text(_names[index], style: const TextStyle(color: Colors.white)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            setState(() {
              _names.removeAt(index);
            });
          },
        ),
      ),
      color: const Color(0xFF606060),
    );
  }
}
