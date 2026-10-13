<?php

namespace App\Http\Controllers;

use App\Models\Book;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;

class BookController extends Controller
{
    public function search(Request $request)
    {
        $query = $request->get('q');
        $isbn = $request->get('isbn');

        if (! $query && ! $isbn) {
            return response()->json([
                'success' => false,
                'message' => 'Parameter q (judul/penulis) atau isbn wajib diisi.',
            ], 422);
        }

        $cacheKey = 'books_search_'.md5($query ?? "isbn_$isbn");

        $results = Cache::remember($cacheKey, 3600, function () use ($query, $isbn) {
            if ($isbn) {
                $response = Http::timeout(10)->get('https://openlibrary.org/api/books', [
                    'bibkeys' => "ISBN:$isbn", 'format' => 'json', 'jscmd' => 'data',
                ]);
                if (! $response->successful()) return [];
                $data = $response->json();
                $items = isset($data["ISBN:$isbn"]) ? [$data["ISBN:$isbn"]] : [];
            } else {
                $response = Http::timeout(10)->get('https://openlibrary.org/search.json', [
                    'q' => $query, 'limit' => 20,
                ]);
                if (! $response->successful()) return [];
                $items = $response->json()['docs'] ?? [];
            }

            return array_map(function ($item) {
                $coverId = $item['cover_i'] ?? null;
                return [
                    'open_library_id' => $item['key'] ?? null,
                    'isbn' => $item['isbn'][0] ?? ($item['isbn'] ?? null),
                    'title' => $item['title'] ?? 'Tanpa Judul',
                    'authors' => $item['author_name'] ?? [],
                    'publisher' => $item['publisher'][0] ?? null,
                    'published_date' => isset($item['first_publish_year'])
                        ? $item['first_publish_year'].'-01-01' : null,
                    'description' => null,
                    'cover_url' => $coverId
                        ? "https://covers.openlibrary.org/b/id/$coverId-L.jpg" : null,
                    'categories' => $item['subject'] ?? [],
                    'page_count' => $item['number_of_pages_median'] ?? null,
                    'avg_rating' => null,
                    'ratings_count' => null,
                ];
            }, $items);
        });

        return response()->json(['success' => true, 'data' => ['books' => $results]]);
    }

    public function show($id)
    {
        $book = Book::with(['reviews.user', 'listings' => fn ($q) => $q->where('status', 'active')->with('user')])
            ->withCount('reviews')->findOrFail($id);

        return response()->json(['success' => true, 'data' => ['book' => $book]]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'open_library_id' => 'nullable|string',
            'isbn' => 'nullable|string',
            'title' => 'required|string',
            'authors' => 'nullable|array',
            'publisher' => 'nullable|string',
            'published_date' => 'nullable|date',
            'description' => 'nullable|string',
            'cover_url' => 'nullable|url',
            'categories' => 'nullable|array',
            'page_count' => 'nullable|integer',
        ]);

        $book = Book::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Buku berhasil ditambahkan.',
            'data' => ['book' => $book],
        ], 201);
    }

    public function popular(Request $request)
    {
        $books = Book::withCount('reviews')
            ->orderByDesc('reviews_count')
            ->limit(min((int) $request->get('limit', 10), 50))->get();

        return response()->json(['success' => true, 'data' => ['books' => $books]]);
    }

    public function index(Request $request)
    {
        $query = Book::withCount('reviews');

        if ($request->has('genre')) {
            $query->whereJsonContains('categories', $request->genre);
        }

        $sort = $request->get('sort', 'reviews');
        if ($sort === 'rating') {
            $query->orderByDesc('avg_rating');
        } elseif ($sort === 'newest') {
            $query->latest();
        } else {
            $query->orderByDesc('reviews_count');
        }

        return response()->json(['success' => true, 'data' => $query->paginate(24)]);
    }
}
