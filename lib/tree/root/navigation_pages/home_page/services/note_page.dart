import 'package:flutter/material.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  _NotesHomePageState createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  List<String> notes = [];

  void _addNote() {
    TextEditingController noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(hintText: 'Enter your note'),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (noteController.text.isNotEmpty) {
                  setState(() {
                    notes.add(noteController.text);
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _openNote(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(
          note: notes[index],
          onSave: (updatedNote) {
            setState(() {
              notes[index] = updatedNote;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 240, 226),
      appBar: AppBar(
        title: const Text('Notes App'),
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNote,
          ),
        ],
      ),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet. Tap + to add one!'))
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(notes[index]),
              onTap: () => _openNote(index), // Open note when tapped
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteNote(index),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NoteDetailPage extends StatefulWidget {
  final String note;
  final Function(String) onSave;

  const NoteDetailPage({super.key, required this.note, required this.onSave});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.note);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    widget.onSave(_noteController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 240, 226),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 225, 240, 226),
        title: const Text('Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _noteController,
          maxLines: null,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }
}