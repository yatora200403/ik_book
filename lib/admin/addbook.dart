import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ik_book/admin/homepageadmin.dart';
import 'package:ik_book/network.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  final String username;
  const AddBook({super.key, required this.username});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formkey = GlobalKey<FormState>();

  final idBookCtrl = TextEditingController();
  final titleCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final positionCtrl = TextEditingController();
  final availabilityCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final imgUrlCtrl = TextEditingController();

  String selectedValue = "yes";

  final picker = ImagePicker();
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imgUrlCtrl.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Book"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: idBookCtrl,
                      validator: (value) =>
                          value!.isEmpty ? "please fill out this field" : null,
                      decoration: InputDecoration(
                          label: Text("Id Book"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: titleCtrl,
                      validator: (value) =>
                          value!.isEmpty ? "please fill out this field" : null,
                      decoration: InputDecoration(
                          label: Text("Title"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: categoryCtrl,
                      validator: (value) =>
                          value!.isEmpty ? "please fill out this field" : null,
                      decoration: InputDecoration(
                          label: Text("Category"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: positionCtrl,
                      validator: (value) =>
                          value!.isEmpty ? "please fill out this field" : null,
                      decoration: InputDecoration(
                          label: Text("Position"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: descriptionCtrl,
                      maxLines: 5,
                      validator: (value) =>
                          value!.isEmpty ? "please fill out this field" : null,
                      decoration: InputDecoration(
                          label: Text("Description"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text("Availability : "),
                        SizedBox(
                          width: 10,
                        ),
                        Radio(
                            value: "yes",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            }),
                        Text("Yes"),
                        Radio(
                            value: "no",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            }),
                        Text("No"),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: imgUrlCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              pickImage();
                            },
                            icon: Icon(Icons.open_in_browser))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Map<String, dynamic> book = {
                            "id_buku": idBookCtrl.text.trim(),
                            "judul": titleCtrl.text.trim(),
                            "description": descriptionCtrl.text.trim(),
                            "category": categoryCtrl.text.trim(),
                            "position": positionCtrl.text.trim(),
                            "availability": selectedValue,
                            "img_url": imgUrlCtrl.text
                          };
                          NetworkApi.addBook(book);
                          final snack = SnackBar(
                            content: Text("Create successfull"),
                            duration: Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageAdmin(
                                        username: widget.username,
                                      )));
                        }
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
