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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.bloomsbury.com%2Fin%2Fdiscover%2Fharry-potter%2Fresources%2Fseries-overview%2F&psig=AOvVaw08RrJ827pL_bazXb8l4PqN&ust=1700615435842000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPC_7ar004IDFQAAAAAdAAAAABAE",
                width: 100,
                height: 200,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                widget.books.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              child: SingleChildScrollView(
                child: Text("description"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
