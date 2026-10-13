<?php

namespace App\Http\Controllers;

use App\Models\Listing;
use App\Models\Order;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function store(Request $request)
    {
        $data = $request->validate([
            'listing_id' => 'required|exists:listings,id',
            'buyer_name' => 'required|string|max:255',
            'buyer_note' => 'nullable|string',
        ], [
            'listing_id.required' => 'Listing tidak valid.',
            'buyer_name.required' => 'Nama pembeli wajib diisi.',
        ]);

        $listing = Listing::with('user')->findOrFail($data['listing_id']);
        $buyer = $request->user();

        if ($listing->status !== 'active') {
            return response()->json([
                'success' => false, 'message' => 'Listing sudah tidak tersedia.',
            ], 422);
        }
        if ($listing->user_id === $buyer->id) {
            return response()->json([
                'success' => false, 'message' => 'Tidak bisa membeli listing sendiri.',
            ], 422);
        }

        $order = Order::create([
            'code' => 'BL-'.now()->format('Ymd').'-'.strtoupper(substr(md5(uniqid()), 0, 6)),
            'buyer_id' => $buyer->id,
            'listing_id' => $listing->id,
            'seller_id' => $listing->user_id,
            'price' => $listing->price,
            'buyer_name' => $data['buyer_name'],
            'buyer_note' => $data['buyer_note'] ?? null,
            'status' => 'pending',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Pesanan dibuat. Lanjutkan chat via WhatsApp penjual.',
            'data' => ['order' => $order->load('listing.book', 'seller')],
        ], 201);
    }

    public function myOrders(Request $request)
    {
        return response()->json(['success' => true, 'data' =>
            Order::with(['listing.book', 'seller'])
                ->where('buyer_id', $request->user()->id)->latest()->paginate(15),
        ]);
    }

    public function mySales(Request $request)
    {
        return response()->json(['success' => true, 'data' =>
            Order::with(['listing.book', 'buyer'])
                ->where('seller_id', $request->user()->id)->latest()->paginate(15),
        ]);
    }

    public function updateStatus(Request $request, $id)
    {
        $order = Order::where('seller_id', $request->user()->id)->findOrFail($id);

        $data = $request->validate([
            'status' => 'required|in:confirmed,done,cancelled',
        ]);

        $order->update(['status' => $data['status']]);

        if ($data['status'] === 'done') {
            $order->listing()->update(['status' => 'sold']);
        }

        return response()->json([
            'success' => true,
            'message' => 'Status pesanan: '.$order->status_label,
            'data' => ['order' => $order->fresh()->load('listing.book', 'buyer')],
        ]);
    }

    public function cancel(Request $request, $id)
    {
        $order = Order::where('buyer_id', $request->user()->id)
            ->where('status', 'pending')->findOrFail($id);
        $order->update(['status' => 'cancelled']);

        return response()->json(['success' => true, 'message' => 'Pesanan dibatalkan.']);
    }
}
