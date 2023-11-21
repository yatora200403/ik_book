import 'package:flutter/material.dart';

class UpdateBook extends StatefulWidget {
  const UpdateBook({super.key});

  @override
  State<UpdateBook> createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Book"),
      ),
      body: Center(
        child: Text("Update Book"),
      ),
    );
  }
}
