import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const RandomizerApp());
}

class RandomizerApp extends StatelessWidget {
  const RandomizerApp({super.key});

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
  const RandomizerHomePage({super.key});

  @override
  _RandomizerHomePageState createState() => _RandomizerHomePageState();
}

class _RandomizerHomePageState extends State<RandomizerHomePage> {
  final List<String> _names = [];
  final TextEditingController _nameController = TextEditingController();
  String _selectedName = '';

  void _addName() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _names.add(_nameController.text);
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
      backgroundColor: const Color(0xFF404040), // Setting background color
      body: Center(
        // Centering the content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter a name',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _addName,
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      backgroundColor: const Color(0xFFFF681F), // Button color
                    ),
                    child: const Text('Add Name'),
                  ),
                  ElevatedButton(
                    onPressed: _randomizeName,
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      backgroundColor: const Color(0xFFFF681F), // Button color
                    ),
                    child: const Text('Randomize'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Randomly Selected Name:',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
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
                      color: const Color(0xFF606060), // Setting card color to match theme
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
