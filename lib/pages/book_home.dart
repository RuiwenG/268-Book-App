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
      child: Scaffold(
        appBar: AppBar(title: const Text('Book Club')),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
            if (state is BookListState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterButton(label: 'Sort by Author', sortByAuthor: true),
                      const SizedBox(width: 16),
                      FilterButton(label: 'Sort by Title', sortByAuthor: false),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return ListTile(
                          leading: Image.asset(book.imageUrl, width: 50, height: 75),
                          title: Text(book.title),
                          subtitle: Text(book.author),
                          onTap: () {
                            context.read<BookBloc>().add(ShowBookDetail(book));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BookDetailState) {
              return Column(
                children: [
                  Expanded(child: BookDetailWidget(book: state.book)),
                  TextButton(
                    onPressed: () => context.read<BookBloc>().add(LoadBooks()),
                    child: const Text('Back to List'),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
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