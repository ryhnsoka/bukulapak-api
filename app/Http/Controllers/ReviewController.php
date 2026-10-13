<?php

namespace App\Http\Controllers;

use App\Models\Book;
use App\Models\Review;
use App\Models\ReviewLike;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    public function index(Request $request)
    {
        $query = Review::with(['user', 'book'])->latest();

        if ($request->has('book_id')) {
            $query->where('book_id', $request->book_id);
        }
        if ($request->has('rating')) {
            $query->where('rating', $request->rating);
        }
        if ($request->has('user_id')) {
            $query->where('user_id', $request->user_id);
        }

        return response()->json(['success' => true, 'data' => $query->paginate(15)]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'book_id' => 'required|exists:books,id',
            'rating' => 'required|integer|min:1|max:5',
            'title' => 'nullable|string|max:255',
            'content' => 'required|string',
        ], [
            'rating.min' => 'Rating minimal 1 bintang.',
            'rating.max' => 'Rating maksimal 5 bintang.',
            'content.required' => 'Isi review wajib diisi.',
        ]);

        $data['user_id'] = $request->user()->id;

        $review = Review::updateOrCreate(
            ['user_id' => $data['user_id'], 'book_id' => $data['book_id']],
            $data
        );

        $this->refreshBookRating($data['book_id']);

        return response()->json([
            'success' => true,
            'message' => 'Review berhasil disimpan.',
            'data' => ['review' => $review->load('user', 'book')],
        ], 201);
    }

    public function show($id)
    {
        return response()->json([
            'success' => true,
            'data' => ['review' => Review::with(['user', 'book'])->findOrFail($id)],
        ]);
    }

    public function myReviews(Request $request)
    {
        return response()->json(['success' => true, 'data' =>
            Review::with(['book', 'user'])->where('user_id', $request->user()->id)
                ->latest()->paginate(15),
        ]);
    }

    public function destroy(Request $request, $id)
    {
        $review = Review::where('user_id', $request->user()->id)->findOrFail($id);
        $bookId = $review->book_id;
        $review->delete();
        $this->refreshBookRating($bookId);

        return response()->json(['success' => true, 'message' => 'Review berhasil dihapus.']);
    }

    public function toggleLike(Request $request, $id)
    {
        $review = Review::findOrFail($id);
        $existing = ReviewLike::where([
            'user_id' => $request->user()->id, 'review_id' => $id,
        ])->first();

        if ($existing) {
            $existing->delete();
            $review->decrement('likes_count');
            $liked = false;
        } else {
            ReviewLike::create(['user_id' => $request->user()->id, 'review_id' => $id]);
            $review->increment('likes_count');
            $liked = true;
        }

        return response()->json(['success' => true, 'data' => [
            'liked' => $liked, 'likes_count' => $review->fresh()->likes_count,
        ]]);
    }

    private function refreshBookRating(int $bookId): void
    {
        $book = Book::find($bookId);
        if (! $book) return;
        $book->update([
            'avg_rating' => round($book->reviews()->avg('rating') ?? 0, 2),
            'ratings_count' => $book->reviews()->count(),
        ]);
    }
}
