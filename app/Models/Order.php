<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Order extends Model
{
    protected $fillable = [
        'code', 'buyer_id', 'listing_id', 'seller_id',
        'price', 'payment_method', 'buyer_name', 'buyer_note',
        'payment_proof', 'status',
    ];

    protected $casts = ['price' => 'integer'];

    protected $appends = ['status_label', 'payment_label'];

    public function buyer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    public function seller(): BelongsTo
    {
        return $this->belongsTo(User::class, 'seller_id');
    }

    public function listing(): BelongsTo
    {
        return $this->belongsTo(Listing::class);
    }

    public function getStatusLabelAttribute(): string
    {
        return match ($this->status) {
            'pending' => 'Menunggu Konfirmasi',
            'confirmed' => 'Dikonfirmasi',
            'done' => 'Selesai',
            'cancelled' => 'Dibatalkan',
            default => $this->status,
        };
    }

    public function getPaymentLabelAttribute(): string
    {
        return match ($this->payment_method ?? 'cod') {
            'cod' => 'COD',
            'transfer' => 'Transfer',
            default => (string) ($this->payment_method ?? 'cod'),
        };
    }
}
