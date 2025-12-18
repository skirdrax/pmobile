import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import 'form_page.dart';

class DetailPage extends StatelessWidget {
  final Note note;
  const DetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        foregroundColor: theme.colorScheme.onPrimary,
        backgroundColor: theme.colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.redAccent,
            onPressed: () => _showDeleteDialog(context),
          ),
        ],
      ),

      // =========================
      // BODY TANPA ROUNDED CARD
      // =========================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          note.content,
          style: TextStyle(
            fontSize: 18,
            height: 1.4,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormPage(note: note),
            ),
          );
        },
      ),
    );
  }

  // ================================
  // DELETE DIALOG
  // ================================
  void _showDeleteDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          title: Text(
            "Delete Note",
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
          content: Text(
            "Yakin ingin menghapus catatan ini?",
            style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.8)),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: theme.colorScheme.primary),
              ),
              onPressed: () => Navigator.pop(ctx),
            ),
            TextButton(
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () async {
                await Provider.of<NotesProvider>(context, listen: false)
                    .deleteNote(note.id!);

                Navigator.pop(ctx);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
