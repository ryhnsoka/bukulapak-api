<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use Illuminate\Http\Request;

class ListingController extends Controller
{
    public function index(Request $request)
    {
        $query = Listing::with(['user', 'book'])->where('status', 'active')->latest();

        if ($request->has('condition')) $query->where('condition', $request->condition);
        if ($request->has('min_price')) $query->where('price', '>=', $request->min_price);
        if ($request->has('max_price')) $query->where('price', '<=', $request->max_price);
        if ($request->has('location_city')) $query->where('location_city', 'like', "%{$request->location_city}%");
        if ($request->has('book_id')) $query->where('book_id', $request->book_id);

        return response()->json(['success' => true, 'data' => $query->paginate(15)]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'book_id' => 'required|exists:books,id',
            'condition' => 'required|in:new,like_new,good,fair,poor',
            'price' => 'required|integer|min:0',
            'location_city' => 'required|string|max:100',
            'wa_number' => 'required|string|regex:/^[0-9]{10,15}$/',
            'description' => 'nullable|string',
            'images' => 'nullable|array|max:5',
            'images.*' => 'url',
        ], [
            'book_id.required' => 'Pilih buku terlebih dahulu.',
            'price.min' => 'Harga tidak boleh negatif (0 = gratis).',
            'location_city.required' => 'Kota wajib diisi.',
            'wa_number.required' => 'Nomor WA wajib diisi agar pembeli bisa menghubungimu.',
            'wa_number.regex' => 'Nomor WA harus 10–15 digit angka (cth: 6281234567890).',
        ]);

        $data['user_id'] = $request->user()->id;
        $data['status'] = 'active';

        $listing = Listing::create($data);

        return response()->json([
            'success' => true,
            'message' => 'Listing buku berhasil dibuat.',
            'data' => ['listing' => $listing->load('book')],
        ], 201);
    }

    public function show($id)
    {
        return response()->json(['success' => true, 'data' => [
            'listing' => Listing::with(['user', 'book'])->findOrFail($id),
        ]]);
    }

    public function update(Request $request, $id)
    {
        $listing = Listing::where('user_id', $request->user()->id)->findOrFail($id);

        $listing->update($request->validate([
            'condition' => 'sometimes|in:new,like_new,good,fair,poor',
            'price' => 'sometimes|integer|min:0',
            'location_city' => 'sometimes|string|max:100',
            'wa_number' => 'sometimes|string|regex:/^[0-9]{10,15}$/',
            'description' => 'nullable|string',
            'images' => 'nullable|array|max:5',
            'images.*' => 'url',
            'status' => 'sometimes|in:active,sold,hidden',
        ]));

        return response()->json([
            'success' => true,
            'message' => 'Listing berhasil diperbarui.',
            'data' => ['listing' => $listing->load('book')],
        ]);
    }

    public function destroy(Request $request, $id)
    {
        Listing::where('user_id', $request->user()->id)->findOrFail($id)->delete();

        return response()->json(['success' => true, 'message' => 'Listing berhasil dihapus.']);
    }

    public function uploadImages(Request $request, $id)
    {
        $listing = Listing::where('user_id', $request->user()->id)->findOrFail($id);

        $data = $request->validate([
            'photos' => 'required|array|min:1|max:5',
            'photos.*' => 'image|mimes:jpg,jpeg,png,webp|max:2048',
        ], [
            'photos.required' => 'Minimal 1 foto buku wajib diunggah.',
            'photos.min' => 'Minimal 1 foto buku wajib diunggah.',
            'photos.max' => 'Maksimal 5 foto.',
            'photos.*.image' => 'File harus berupa gambar.',
            'photos.*.max' => 'Ukuran tiap foto maksimal 2MB.',
        ]);

        $urls = $listing->images ?? [];
        foreach ($request->file('photos') as $file) {
            $name = 'listing_'.$listing->id.'_'.time().'_'.uniqid().'.'.$file->getClientOriginalExtension();
            $file->move(public_path('uploads'), $name);
            $urls[] = rtrim(config('app.url'), '/').'/uploads/'.$name;
        }
        $listing->update(['images' => array_slice($urls, 0, 5)]);

        return response()->json([
            'success' => true,
            'message' => 'Foto berhasil diunggah.',
            'data' => ['listing' => $listing->fresh()->load('book')],
        ]);
    }

    public function myListings(Request $request)
    {
        return response()->json(['success' => true, 'data' =>
            Listing::with('book')->where('user_id', $request->user()->id)
                ->latest()->paginate(15),
        ]);
    }
}
