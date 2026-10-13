<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->string('open_library_id')->nullable()->unique();
            $table->string('isbn')->nullable()->index();
            $table->string('title');
            $table->json('authors')->nullable();
            $table->string('publisher')->nullable();
            $table->string('published_date')->nullable();
            $table->longText('description')->nullable();
            $table->string('cover_url')->nullable();
            $table->json('categories')->nullable();
            $table->integer('page_count')->nullable();
            $table->decimal('avg_rating', 3, 2)->nullable();
            $table->integer('ratings_count')->default(0);
            $table->timestamps();
            $table->index('title');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
