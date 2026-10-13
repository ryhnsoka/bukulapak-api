<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\Bookmark;
use App\Models\Listing;
use Illuminate\Http\Request;

class BookmarkController extends Controller
{
    public function toggle(Request $request)
    {
        $data = $request->validate([
            'bookmarkable_type' => 'required|in:'.Book::class.','.Listing::class,
            'bookmarkable_id' => 'required|integer',
        ]);

        $existing = Bookmark::where([
            'user_id' => $request->user()->id,
            'bookmarkable_type' => $data['bookmarkable_type'],
            'bookmarkable_id' => $data['bookmarkable_id'],
        ])->first();

        if ($existing) {
            $existing->delete();
            $bookmarked = false;
        } else {
            Bookmark::create([
                'user_id' => $request->user()->id,
                'bookmarkable_type' => $data['bookmarkable_type'],
                'bookmarkable_id' => $data['bookmarkable_id'],
            ]);
            $bookmarked = true;
        }

        return response()->json(['success' => true, 'data' => ['bookmarked' => $bookmarked]]);
    }

    public function myBookmarks(Request $request)
    {
        return response()->json(['success' => true, 'data' =>
            Bookmark::with('bookmarkable')->where('user_id', $request->user()->id)
                ->latest()->paginate(20),
        ]);
    }
}
