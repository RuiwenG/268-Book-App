part of 'book_bloc.dart';

abstract class BookState {}

class BookListState extends BookState {
  late final List<Book> books;
  late final bool sortedByAuthor;
  BookListState({required this.books, required this.sortedByAuthor});
}

class BookDetailState extends BookState {
  final Book book;
  BookDetailState(this.book);
}
