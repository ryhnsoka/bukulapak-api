<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\MorphMany;

class Book extends Model
{
    protected $fillable = [
        'open_library_id', 'isbn', 'title', 'authors', 'publisher',
        'published_date', 'description', 'cover_url', 'categories',
        'page_count', 'avg_rating', 'ratings_count',
    ];

    protected $casts = [
        'authors' => 'array',
        'categories' => 'array',
        'avg_rating' => 'decimal:2',
    ];

    public function reviews(): HasMany
    {
        return $this->hasMany(Review::class);
    }

    public function listings(): HasMany
    {
        return $this->hasMany(Listing::class);
    }

    public function bookmarks(): MorphMany
    {
        return $this->morphMany(Bookmark::class, 'bookmarkable');
    }
}
