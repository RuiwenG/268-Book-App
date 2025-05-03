import 'package:bloc/bloc.dart';
import '../book.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
part 'book_event.dart';
part 'book_state.dart';


class BookBloc extends Bloc<BookEvent, BookState>{
  final List<Book> _allBooks = [];
  // fake description
  String textFake = lorem();

  BookBloc(): super(BookListState(books: [], sortedByAuthor: true)){
    on<LoadBooks>((event, emit) {
      _init();
      _sortAndEmit(emit, sortByAuthor: true);
    });
    on<FilterBooks>((event, emit){
      // this is the function to filter books based on the title /author
      _sortAndEmit(emit, sortByAuthor: event.sortByAuthor);
    });
    on<ShowBookDetail>((event, emit){
      // this function shows the details of the book
      emit(BookDetailState(event.book));
    });
  }

void _init() {
  _allBooks.clear();
  _allBooks.addAll([
    Book("Carmer and Grit", "Sarah Jean Horwitz", textFake, 'assets/Book=1.png'),
    Book("Little Gods", "Meng Jin", textFake, 'assets/Book=2.png'),
    Book("A Clockwork Orange", "Anthony Burgess", textFake, 'assets/Book=3.png'),
    Book("The Imperfections of Memory", "Angelina Aludo" ,textFake, 'assets/Book=4.png'),
    Book("Big Deal", "Hisham Al Gurg", textFake, 'assets/Book=5.png'),
    Book("James and the Giant Peach", "Roald Dahl", textFake, 'assets/Book=6.jpg'),
    Book("Don't look back", "Isaac Nelson", textFake, 'assets/Book=7.png'),
  ]);
}
  // the helper function that sorts book based on author or title
  void _sortAndEmit(Emitter<BookState> emit, {required bool sortByAuthor}) {
    List<Book> sorted = List.from(_allBooks);
    sorted.sort((a, b) =>
        sortByAuthor ? a.author.compareTo(b.author) : a.title.compareTo(b.title));
    emit(BookListState(books: sorted, sortedByAuthor: sortByAuthor));
  }
}
