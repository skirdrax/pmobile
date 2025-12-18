<?php

namespace App\Http\Controllers\Api;

use App\Models\Note;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class NoteController extends Controller
{
    public function index(Request $request)
    {
        return Note::where('user_id', $request->user()->id)->get();
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'content' => 'nullable',
        ]);

        return Note::create([
            'user_id' => $request->user()->id,
            'title' => $request->title,
            'content' => $request->content,
        ]);
    }

    public function update(Request $request, Note $note)
    {
        if ($note->user_id != $request->user()->id) {
            return response()->json(['message' => 'Akses ditolak'], 403);
        }

        $note->update($request->only('title', 'content'));

        return $note;
    }

    public function destroy(Request $request, Note $note)
    {
        if ($note->user_id != $request->user()->id) {
            return response()->json(['message' => 'Akses ditolak'], 403);
        }

        $note->delete();

        return response()->json(['message' => 'Catatan dihapus']);
    }
}
