import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';
import 'widgets/book_detail.dart';

class BookHome extends StatelessWidget {
  const BookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc()..add(LoadBooks()),
      child: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          // Shared Scaffold
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Text('sort by'),
                        SizedBox(width: 8),
                        FilterButton(label: 'Author', sortByAuthor: true),
                        SizedBox(width: 16),
                        FilterButton(label: 'Title', sortByAuthor: false),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listState.books.length,
                      itemBuilder: (context, index) {
                        final book = listState.books[index];
                        return ListTile(
                          leading: Image.asset(
                            book.imageUrl,
                            width: 50,
                            height: 75,
                          ),
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
