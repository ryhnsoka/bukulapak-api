<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Listing extends Model
{
    protected $fillable = [
        'user_id', 'book_id', 'condition', 'price', 'location_city',
        'wa_number', 'description', 'images', 'status',
    ];

    protected $casts = ['images' => 'array', 'price' => 'integer'];

    protected $appends = ['condition_label'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function book(): BelongsTo
    {
        return $this->belongsTo(Book::class);
    }

    public function conversations(): HasMany
    {
        return $this->hasMany(Conversation::class);
    }

    public function bookmarks(): MorphMany
    {
        return $this->morphMany(Bookmark::class, 'bookmarkable');
    }

    public function getConditionLabelAttribute(): string
    {
        return match ($this->condition) {
            'new' => 'Baru',
            'like_new' => 'Seperti Baru',
            'good' => 'Baik',
            'fair' => 'Cukup',
            'poor' => 'Rusak Ringan',
            default => $this->condition,
        };
    }
}
