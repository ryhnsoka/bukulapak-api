<?php

namespace App\Http\Controllers;

use App\Models\Conversation;
use App\Models\Listing;
use App\Models\Message;
use Illuminate\Http\Request;

class ConversationController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        $conversations = Conversation::with(['listing.book', 'buyer', 'seller', 'messages' => fn ($q) => $q->latest()->limit(1)])
            ->where(fn ($q) => $q->where('buyer_id', $user->id)->orWhere('seller_id', $user->id))
            ->orderByDesc('last_message_at')
            ->paginate(20);

        $conversations->getCollection()->transform(function ($c) use ($user) {
            $c->other_party = $user->id === $c->buyer_id ? $c->seller : $c->buyer;
            $c->last_message = $c->messages->first();
            unset($c->messages);
            return $c;
        });

        return response()->json(['success' => true, 'data' => $conversations]);
    }

    public function store(Request $request)
    {
        $data = $request->validate(['listing_id' => 'required|exists:listings,id']);
        $listing = Listing::findOrFail($data['listing_id']);
        $buyer = $request->user();

        if ($listing->user_id === $buyer->id) {
            return response()->json([
                'success' => false, 'message' => 'Tidak bisa chat dengan listing sendiri.',
            ], 422);
        }

        $conversation = Conversation::firstOrCreate(
            ['listing_id' => $listing->id, 'buyer_id' => $buyer->id],
            ['seller_id' => $listing->user_id, 'last_message_at' => now()]
        );

        return response()->json([
            'success' => true,
            'message' => 'Percakapan dimulai.',
            'data' => ['conversation' => $conversation->load('listing.book', 'buyer', 'seller')],
        ], 201);
    }

    public function show(Request $request, $id)
    {
        $conversation = Conversation::with(['listing.book', 'buyer', 'seller'])->findOrFail($id);
        $user = $request->user();

        if ($conversation->buyer_id !== $user->id && $conversation->seller_id !== $user->id) {
            return response()->json(['success' => false, 'message' => 'Tidak diizinkan.'], 403);
        }

        $conversation->other_party = $user->id === $conversation->buyer_id
            ? $conversation->seller : $conversation->buyer;

        return response()->json(['success' => true, 'data' => ['conversation' => $conversation]]);
    }
}
