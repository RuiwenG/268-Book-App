import 'package:book_app/pages/bloc/book_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/widgets/book_detail.dart';

class BookHome extends StatelessWidget{
  const BookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Club"),
        actions: [
          // adds back button
        ],
      ),
      body: BlocBuilder<BookBloc, BookState> (
        builder: (context, state){
          if (state is BookListState){
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index){
                final book = state.books[index];
                return ListTile(
                  leading: Image.network(book.imageUrl, width : 50),
                  title: Text (book.title),
                  onTap: (){
                    context.read<BookBloc>().add(ShowBookDetail(book));
                  },
                );
              },
            );
          }
          if (state is BookDetailState) {
            return BookDetailWidget(book: state.book);
          }
          else if (state is BookDetailState){
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed:() => context.read<BookBloc>().add(BackToList()), 
                  icon: const Icon(Icons.arrow_back)),
              ),
            );

          }
        },
      )

      
    );
  }

}