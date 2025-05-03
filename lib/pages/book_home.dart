import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';
import 'widgets/book_detail.dart';
import 'book.dart';

class BookHome extends StatelessWidget {
  const BookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc()..add(LoadBooks()),
      child: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state is BookDetailState ? state.book.title : 'Book Club',
              ),
              leading:
                  state is BookDetailState
                      ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          context.read<BookBloc>().add(LoadBooks());
                        },
                      )
                      : null,
            ),
            body: switch (state) {
              BookListState listState => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          'Sort by',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        FilterButton(label: 'Author', sortByAuthor: true),
                        SizedBox(width: 8),
                        FilterButton(label: 'Title', sortByAuthor: false),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Books',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  BookListView(books: listState.books), // Using the new widget
                ],
              ),
              BookDetailState detailState => BookDetailWidget(
                book: detailState.book,
              ),
              _ => const Center(child: CircularProgressIndicator()),
            },
          );
        },
      ),
    );
  }
}

class BookListView extends StatelessWidget {
  final List<Book> books;

  const BookListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Constrain the height of the Row
      height: 150, // Match the height of your book items
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the top
          children:
              books.map((book) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<BookBloc>().add(ShowBookDetail(book));
                    },
                    child: SizedBox(
                      width: 100,
                      height: 150,
                      child: Image.asset(book.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool sortByAuthor;

  const FilterButton({
    super.key,
    required this.label,
    required this.sortByAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<BookBloc>().add(FilterBooks(sortByAuthor: sortByAuthor));
      },
      child: Text(label),
    );
  }
}
