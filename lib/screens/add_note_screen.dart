import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final int userId;

  const AddNoteScreen({super.key, required this.userId});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titreController = TextEditingController();
  final _contenuController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();
    final note = Note(
      titre: _titreController.text.trim(),
      contenu: _contenuController.text.trim(),
      dateCreation: now,
      dateModification: now,
      userId: widget.userId,
    );

    await DatabaseHelper.instance.insertNote(note);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note enregistrée'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Ajout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Titre de la note',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titreController,
                decoration: _inputDecoration(),
                validator: (v) =>
                    v!.isEmpty ? 'Le titre est obligatoire' : null,
              ),
              const SizedBox(height: 20),
              const Text('Contenu de la note',
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contenuController,
                maxLines: 10,
                decoration: _inputDecoration(),
                validator: (v) =>
                    v!.isEmpty ? 'Le contenu est obligatoire' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Enregistrer',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2196F3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2196F3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF2196F3), width: 2),
      ),
    );
  }
}