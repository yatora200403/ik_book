import 'package:flutter/material.dart';
import 'package:ik_book/model/books.dart';

class BookDetail extends StatefulWidget {
  final Books books;
  const BookDetail({super.key, required this.books});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
      ),
      body: Center(
        child: Text(widget.books.title),
      ),
    );
  }
}
