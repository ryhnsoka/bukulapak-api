<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\Message;
use Illuminate\Http\Request;

class MessageController extends Controller
{
    private function authorize(Conversation $conversation, $user): bool
    {
        return $conversation->buyer_id === $user->id || $conversation->seller_id === $user->id;
    }

    public function index(Request $request, $conversationId)
    {
        $conversation = Conversation::findOrFail($conversationId);

        if (! $this->authorize($conversation, $request->user())) {
            return response()->json(['success' => false, 'message' => 'Tidak diizinkan.'], 403);
        }

        Message::where('conversation_id', $conversationId)
            ->where('user_id', '!=', $request->user()->id)
            ->whereNull('read_at')->update(['read_at' => now()]);

        return response()->json(['success' => true, 'data' =>
            Message::with('user')->where('conversation_id', $conversationId)
                ->latest()->paginate(50),
        ]);
    }

    public function store(Request $request, $conversationId)
    {
        $conversation = Conversation::findOrFail($conversationId);

        if (! $this->authorize($conversation, $request->user())) {
            return response()->json(['success' => false, 'message' => 'Tidak diizinkan.'], 403);
        }

        $message = Message::create([
            'conversation_id' => $conversationId,
            'user_id' => $request->user()->id,
            'content' => $request->validate(['content' => 'required|string'])['content'],
        ]);

        $conversation->update(['last_message_at' => now()]);

        return response()->json([
            'success' => true,
            'message' => 'Pesan terkirim.',
            'data' => ['message' => $message->load('user')],
        ], 201);
    }
}
