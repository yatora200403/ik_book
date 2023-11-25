// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ik_book/login.dart';
import 'package:ik_book/user/bookDetail.dart';
import 'package:ik_book/model/books.dart';
import 'package:ik_book/network.dart';
// import 'package:http/http.dart' as http;

class HomePageUser extends StatefulWidget {
  final String username;
  const HomePageUser({super.key, required this.username});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchCtrl = TextEditingController();

  List<dynamic> _foundBook = [];

  @override
  void initState() {
    _foundBook = NetworkApi.getAllBooks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("HomePageUser"),
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu)),
      ),
      drawer: MyDrawer(
        username: widget.username,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            height: 50,
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                  label: Text("Search"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => searchCtrl.clear(),
                  )),
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _foundBook = NetworkApi.getAllBooks;
                  } else {
                    _foundBook = NetworkApi.getAllBooks
                        .where((book) => book['judul']
                            .toString()
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundBook.length,
              itemBuilder: (context, index) => GestureDetector(
                child: Container(
                  height: 150,
                  child: Card(
                    color: Colors.purple,
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 80, 40),
                          child: ListTile(
                            title: Text(
                              _foundBook[index]['judul'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                          child: _foundBook[index]['img_url'] != null
                              ? _foundBook[index]['img_url']
                                          .toString()
                                          .startsWith('http') ||
                                      _foundBook[index]['img_url']
                                          .toString()
                                          .startsWith('https')
                                  ? Image.network(
                                      _foundBook[index]['img_url'],
                                      width: 100,
                                    )
                                  : Image.file(
                                      File(_foundBook[index]['img_url']),
                                      width: 100,
                                    )
                              : Text("Not available"),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  String title = _foundBook[index]['judul'];
                  String urlImg = _foundBook[index]['img_url'];
                  String description = _foundBook[index]['description'];
                  String category = _foundBook[index]['category'];
                  String position = _foundBook[index]['position'];
                  String availability = _foundBook[index]['availability'];
                  String id = _foundBook[index]['id_buku'];

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookDetail(
                                  books: Books(
                                title: title,
                                urlImg: urlImg,
                                description: description,
                                category: category,
                                position: position,
                                availability: availability,
                                id: id,
                              ))));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  final String username;
  const MyDrawer({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
          child: Text(
            username.toUpperCase(),
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        InkWell(
          child: ListTile(
            title: Text("Logout"),
          ),
          splashColor: Colors.red,
          highlightColor: Colors.red,
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      ]),
    );
  }
}
