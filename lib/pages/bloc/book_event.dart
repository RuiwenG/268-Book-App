part of 'book_bloc.dart';
// import '../book.dart';


abstract class BookEvent {}

class LoadBooks extends BookEvent {}

class FilterBooks extends BookEvent {
  final bool sortByAuthor; // true = author, false = title

  FilterBooks({required this.sortByAuthor});
}

class ShowBookDetail extends BookEvent {
  late final Book book;
  ShowBookDetail(this.book);
}

class BackToList extends BookEvent {}
