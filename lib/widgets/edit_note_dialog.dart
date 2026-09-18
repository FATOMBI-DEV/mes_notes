import 'package:flutter/material.dart';
import '../models/note.dart';

class EditNoteDialog extends StatefulWidget {
  final Note note;
  final Function(Note) onSave;

  const EditNoteDialog({
    super.key,
    required this.note,
    required this.onSave,
  });

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  late TextEditingController _titreController;
  late TextEditingController _contenuController;

  @override
  void initState() {
    super.initState();
    _titreController = TextEditingController(text: widget.note.titre);
    _contenuController = TextEditingController(text: widget.note.contenu);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF2196F3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Modifier la note',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Titre de la note',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: _titreController,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 16),
              const Text('Contenu de la note',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 6),
              TextField(
                controller: _contenuController,
                maxLines: 6,
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Annuler',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final updated = Note(
                        id: widget.note.id,
                        titre: _titreController.text.trim(),
                        contenu: _contenuController.text.trim(),
                        dateCreation: widget.note.dateCreation,
                        dateModification:
                            DateTime.now().toIso8601String(),
                        userId: widget.note.userId,
                      );
                      widget.onSave(updated);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Enregistrer',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2196F3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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