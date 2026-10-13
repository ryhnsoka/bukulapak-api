<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\ReviewController;
use App\Http\Controllers\ListingController;
use App\Http\Controllers\BookmarkController;
use App\Http\Controllers\ConversationController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\OrderController;

Route::get('/health', fn () => response()->json(['status' => 'ok', 'app' => 'BukuLapak']));

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login'])->middleware('throttle:5,1');

Route::get('/books/search', [BookController::class, 'search']);
Route::get('/books/popular', [BookController::class, 'popular']);
Route::get('/books', [BookController::class, 'index']);
Route::get('/books/{id}', [BookController::class, 'show']);
Route::post('/books', [BookController::class, 'store'])->middleware('auth:sanctum');

Route::get('/reviews', [ReviewController::class, 'index']);
Route::get('/reviews/my', [ReviewController::class, 'myReviews'])->middleware('auth:sanctum');
Route::get('/reviews/{id}', [ReviewController::class, 'show']);
Route::post('/reviews', [ReviewController::class, 'store'])->middleware('auth:sanctum');
Route::delete('/reviews/{id}', [ReviewController::class, 'destroy'])->middleware('auth:sanctum');
Route::post('/reviews/{id}/like', [ReviewController::class, 'toggleLike'])->middleware('auth:sanctum');

Route::get('/listings/my', [ListingController::class, 'myListings'])->middleware('auth:sanctum');
Route::get('/listings', [ListingController::class, 'index']);
Route::get('/listings/{id}', [ListingController::class, 'show']);
Route::post('/listings', [ListingController::class, 'store'])->middleware('auth:sanctum');
Route::put('/listings/{id}', [ListingController::class, 'update'])->middleware('auth:sanctum');
Route::delete('/listings/{id}', [ListingController::class, 'destroy'])->middleware('auth:sanctum');
Route::post('/listings/{id}/images', [ListingController::class, 'uploadImages'])->middleware('auth:sanctum');

Route::post('/bookmarks', [BookmarkController::class, 'toggle'])->middleware('auth:sanctum');
Route::get('/bookmarks/my', [BookmarkController::class, 'myBookmarks'])->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::post('/orders', [OrderController::class, 'store']);
    Route::get('/orders/my', [OrderController::class, 'myOrders']);
    Route::get('/orders/sales', [OrderController::class, 'mySales']);
    Route::patch('/orders/{id}/status', [OrderController::class, 'updateStatus']);
    Route::delete('/orders/{id}', [OrderController::class, 'cancel']);
    Route::get('/conversations', [ConversationController::class, 'index']);
    Route::post('/conversations', [ConversationController::class, 'store']);
    Route::get('/conversations/{id}', [ConversationController::class, 'show']);
    Route::get('/conversations/{id}/messages', [MessageController::class, 'index']);
    Route::post('/conversations/{id}/messages', [MessageController::class, 'store']);
});
