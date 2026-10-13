<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('listings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('book_id')->constrained()->cascadeOnDelete();
            $table->enum('condition', ['new', 'like_new', 'good', 'fair', 'poor'])->default('good');
            $table->unsignedInteger('price');
            $table->string('location_city');
            $table->longText('description')->nullable();
            $table->json('images')->nullable();
            $table->enum('status', ['active', 'sold', 'hidden'])->default('active');
            $table->timestamps();
            $table->index(['status', 'created_at']);
            $table->index(['location_city', 'status']);
            $table->index('price');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('listings');
    }
};
