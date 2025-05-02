// import '../book.dart';
part of 'book_bloc.dart';

abstract class BookState {}

class BookListState extends BookState {
  late final List<Book> books;
  late final bool sortByAuthor;
}

class BookDetailState extends BookState {
  final Book book;
  BookDetailState(this.book);
}
