import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/notes_api.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];
  bool isLoading = false;

  // ========================
  // LOAD NOTES
  // ========================
  Future<void> fetchNotes() async {
    isLoading = true;
    notifyListeners();

    try {
      notes = await NotesApi.getNotes();
    } catch (e) {
      print("FETCH NOTES ERROR: $e");
      notes = [];
    }

    isLoading = false;
    notifyListeners();
  }

  // ========================
  // ADD NOTE
  // ========================
  Future<void> addNote(String title, String content) async {
    try {
      await NotesApi.createNote(title, content);
      await fetchNotes();
    } catch (e) {
      print("ADD NOTE ERROR: $e");
    }
  }

  // ========================
  // UPDATE NOTE
  // ========================
  Future<void> updateNote(Note note) async {
    try {
      await NotesApi.updateNote(note);
      await fetchNotes();
    } catch (e) {
      print("UPDATE NOTE ERROR: $e");
    }
  }

  // ========================
  // DELETE NOTE
  // ========================
  Future<void> deleteNote(int id) async {
    try {
      await NotesApi.deleteNote(id);
      await fetchNotes();
    } catch (e) {
      print("DELETE NOTE ERROR: $e");
    }
  }
}
