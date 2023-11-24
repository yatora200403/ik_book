import 'dart:io';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: widget.books.urlImg.toString().startsWith('http') ||
                          widget.books.urlImg.toString().startsWith('https')
                      ? Image.network(
                          widget.books.urlImg,
                          width: 250,
                          height: 300,
                        )
                      : Image.file(
                          File(widget.books.urlImg),
                          width: 250,
                          height: 300,
                        )),
              SizedBox(
                height: 16,
              ),
              Text(
                widget.books.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Category : ",
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.books.category,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Position : ",
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.books.position,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Availability : ",
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          widget.books.availability,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: widget.books.availability == "yes"
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("${widget.books.description} more..."),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Baca Buku"))
            ],
          ),
        ),
      ),
    );
  }
}
