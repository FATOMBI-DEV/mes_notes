import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';
import 'add_note_screen.dart';
import 'login_screen.dart';
import '../widgets/edit_note_dialog.dart';
import '../widgets/delete_confirm_dialog.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  final String username;

  const HomeScreen({
    super.key,
    required this.userId,
    required this.username,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    final notes = await DatabaseHelper.instance.getNotesByUser(widget.userId);
    setState(() {
      _notes = notes;
      _isLoading = false;
    });
  }

  void _showEditDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => EditNoteDialog(
        note: note,
        onSave: (updated) async {
          await DatabaseHelper.instance.updateNote(updated);
          _loadNotes();
        },
      ),
    );
  }

  void _showDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmDialog(
        onConfirm: () async {
          await DatabaseHelper.instance.deleteNote(note.id!);
          _loadNotes();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text('Mes notes', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? const Center(
                  child: Text(
                    'Aucune note.\nCliquez sur + pour en ajouter.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      child: ListTile(
                        title: Text(
                          note.titre,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Color(0xFF1A237E)),
                              onPressed: () => _showEditDialog(note),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color(0xFFF44336)),
                              onPressed: () => _showDeleteDialog(note),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF50),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(userId: widget.userId),
            ),
          );
          _loadNotes();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}