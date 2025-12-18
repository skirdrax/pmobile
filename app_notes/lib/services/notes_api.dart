import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note.dart';
import '../utils/shared_pref.dart';

class NotesApi {
  static const baseUrl = "https://long-palpitant-jinglingly.ngrok-free.dev/api";

  // Ambil token dari SharedPref
  static Future<Map<String, String>> _headers() async {
    final token = SharedPref.getToken();

    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      "ngrok-skip-browser-warning": "true",
    };
  }

  // ======================
  // GET ALL NOTES
  // ======================
  static Future<List<Note>> getNotes() async {
    final headers = await _headers();

    final res = await http.get(
      Uri.parse("$baseUrl/notes"),
      headers: headers,
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      return (data as List).map((item) => Note.fromJson(item)).toList();
    }

    throw Exception("Gagal mengambil notes: ${res.body}");
  }

  // ======================
  // CREATE NOTE
  // ======================
  static Future<bool> createNote(String title, String content) async {
    final headers = await _headers();

    final res = await http.post(
      Uri.parse("$baseUrl/notes"),
      headers: headers,
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );

    return res.statusCode == 200 || res.statusCode == 201;
  }

  // ======================
  // UPDATE NOTE
  // ======================
  static Future<bool> updateNote(Note note) async {
    final headers = await _headers();

    final res = await http.put(
      Uri.parse("$baseUrl/notes/${note.id}"),
      headers: headers,
      body: jsonEncode({
        "title": note.title,
        "content": note.content,
      }),
    );

    return res.statusCode == 200;
  }

  // ======================
  // DELETE NOTE
  // ======================
  static Future<bool> deleteNote(int id) async {
    final headers = await _headers();

    final res = await http.delete(
      Uri.parse("$baseUrl/notes/$id"),
      headers: headers,
    );

    return res.statusCode == 200;
  }
}
