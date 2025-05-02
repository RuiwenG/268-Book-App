import 'package:flutter/material.dart';
import '../book.dart';
import 'book_image.dart';

class BookDetailWidget extends StatelessWidget {
  final Book book;

  const BookDetailWidget({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookImageWidget(imageUrl: book.imageUrl),
          const SizedBox(height: 12),
          Text(book.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('by ${book.author}', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Text(book.description),
        ],
      ),
    );
  }
}
