<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Review extends Model
{
    protected $fillable = [
        'user_id', 'book_id', 'rating', 'title', 'content', 'likes_count',
    ];

    protected $casts = ['rating' => 'integer', 'likes_count' => 'integer'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function book(): BelongsTo
    {
        return $this->belongsTo(Book::class);
    }

    public function likes(): HasMany
    {
        return $this->hasMany(ReviewLike::class);
    }
}
