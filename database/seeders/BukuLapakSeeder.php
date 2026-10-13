<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Listing;
use App\Models\Review;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class BukuLapakSeeder extends Seeder
{
    public function run(): void
    {
        $andi = User::create([
            'name' => 'Andi Wijaya', 'email' => 'andi@bukulapak.id',
            'password' => Hash::make('password123'),
        ]);
        $sari = User::create([
            'name' => 'Sari Putri', 'email' => 'sari@bukulapak.id',
            'password' => Hash::make('password123'),
        ]);

        $books = [
            [
                'open_library_id' => '/works/OL82563W',
                'title' => 'Harry Potter and the Philosopher\'s Stone',
                'authors' => ['J. K. Rowling'],
                'publisher' => 'Bloomsbury',
                'published_date' => '1997-06-26',
                'description' => 'Petualangan pertama Harry Potter di Hogwarts.',
                'cover_url' => 'https://covers.openlibrary.org/b/id/15155833-L.jpg',
                'categories' => ['Fantasy'],
                'page_count' => 223,
            ],
            [
                'open_library_id' => '/works/OL262758W',
                'title' => 'Laskar Pelangi',
                'authors' => ['Andrea Hirata'],
                'publisher' => 'Bentang Pustaka',
                'published_date' => '2005-01-01',
                'description' => 'Kisah inspiratif anak-anak Belitung.',
                'cover_url' => null,
                'categories' => ['Fiksi Indonesia'],
                'page_count' => 529,
            ],
            [
                'open_library_id' => '/works/OL14906239W',
                'title' => 'Atomic Habits',
                'authors' => ['James Clear'],
                'publisher' => 'Avery',
                'published_date' => '2018-10-16',
                'description' => 'Membangun kebiasaan baik lewat perubahan kecil.',
                'cover_url' => null,
                'categories' => ['Self-Help'],
                'page_count' => 320,
            ],
        ];

        foreach ($books as $data) {
            $book = Book::create($data);

            Review::create([
                'user_id' => $andi->id, 'book_id' => $book->id,
                'rating' => 5, 'title' => 'Wajib baca!',
                'content' => 'Buku yang sangat berkesan, ceritanya mengalir dan sulit berhenti dibaca.',
            ]);
            Review::create([
                'user_id' => $sari->id, 'book_id' => $book->id,
                'rating' => 4, 'title' => 'Bagus',
                'content' => 'Menikmati setiap babnya, walau awalnya agak lambat.',
            ]);

            $book->update([
                'avg_rating' => 4.5, 'ratings_count' => 2,
            ]);

            Listing::create([
                'user_id' => $andi->id, 'book_id' => $book->id,
                'condition' => 'good', 'price' => 45000,
                'location_city' => 'Jakarta',
                'description' => 'Kondisi mulus, tanpa coretan.',
                'status' => 'active',
            ]);
        }

        Listing::create([
            'user_id' => $sari->id, 'book_id' => Book::first()->id,
            'condition' => 'like_new', 'price' => 60000,
            'location_city' => 'Bandung',
            'description' => 'Seperti baru, hanya dibaca sekali.',
            'status' => 'active',
        ]);
    }
}
