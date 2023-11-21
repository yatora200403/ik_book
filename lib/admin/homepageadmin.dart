import 'package:flutter/material.dart';
import 'package:ik_book/user/bookDetail.dart';
import 'package:ik_book/model/books.dart';
import 'package:ik_book/admin/addbook.dart';

class HomepageAdmin extends StatefulWidget {
  const HomepageAdmin({super.key});

  @override
  State<HomepageAdmin> createState() => _HomepageAdminState();
}

class _HomepageAdminState extends State<HomepageAdmin> {
  final searchCtrl = TextEditingController();

  final List<String> _books = [
    "Harry Potter",
    "Sherlock Holmes",
    "National Geography",
    "Miracle",
    "A Little Bird and Girl"
  ];
  List<String> _bookFound = [];
  @override
  void initState() {
    _bookFound = _books;
    super.initState();
  }

  void _filterFunc(String keyword) {
    List<String> _result = [];
    if (keyword.isEmpty) {
      _result = _books;
    } else {
      _result = _books
          .where((book) => book.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _bookFound = _result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        leading: null,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AddBook())));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            height: 50,
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => searchCtrl.clear(),
                  )),
              onChanged: (value) => _filterFunc(value),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _bookFound.length,
              itemBuilder: (context, index) => GestureDetector(
                child: Card(
                  color: Colors.purple,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(
                      _bookFound[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: () {
                  String title = _bookFound[index];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookDetail(books: Books(title: title))));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
