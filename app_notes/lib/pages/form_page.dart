import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

class FormPage extends StatefulWidget {
  final Note? note;
  const FormPage({super.key, this.note});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final titleC = TextEditingController();
  final contentC = TextEditingController();

  double fontSize = 16;
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  @override
  void initState() {
    super.initState();

    if (widget.note != null) {
      titleC.text = widget.note!.title;
      contentC.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          widget.note == null ? "Add Note" : "Edit Note",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TITLE FIELD
            TextField(
              controller: titleC,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==========================
            // ✨ TOOLBAR TEXT EDITOR
            // ==========================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bold
                  IconButton(
                    icon: Icon(Icons.format_bold,
                        color: isBold ? theme.primaryColor : Colors.grey),
                    onPressed: () {
                      setState(() => isBold = !isBold);
                    },
                  ),

                  // Italic
                  IconButton(
                    icon: Icon(Icons.format_italic,
                        color: isItalic ? theme.primaryColor : Colors.grey),
                    onPressed: () {
                      setState(() => isItalic = !isItalic);
                    },
                  ),

                  // Underline
                  IconButton(
                    icon: Icon(Icons.format_underline,
                        color: isUnderline ? theme.primaryColor : Colors.grey),
                    onPressed: () {
                      setState(() => isUnderline = !isUnderline);
                    },
                  ),

                  // Font size -
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (fontSize > 10) {
                        setState(() => fontSize--);
                      }
                    },
                  ),

                  Text("${fontSize.toInt()}"),

                  // Font size +
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      if (fontSize < 40) {
                        setState(() => fontSize++);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ==========================
            // CONTENT FIELD
            // ==========================
            Expanded(
              child: TextField(
                controller: contentC,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: "Content",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  decoration:
                      isUnderline ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (titleC.text.isEmpty || contentC.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Form tidak boleh kosong!")),
                    );
                    return;
                  }

                  if (widget.note == null) {
                    await notesProvider.addNote(
                      titleC.text,
                      contentC.text,
                    );
                  } else {
                    await notesProvider.updateNote(
                      Note(
                        id: widget.note!.id,
                        title: titleC.text,
                        content: contentC.text,
                      ),
                    );
                  }

                  if (mounted) Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
