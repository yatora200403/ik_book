import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ik_book/admin/homepageadmin.dart';
import 'package:ik_book/network.dart';
import 'package:ik_book/user/homepageuser.dart';
import 'package:http/http.dart' as http;
import 'package:ik_book/session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> login(String username, String password) async {
    NetworkApi.setFileEnd = "user";
    NetworkApi.setActionApi = "login";

    Map<String, dynamic> mapResponse = {};
    final response = await http.post(Uri.parse(NetworkApi.getPostUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }));
    if (response.statusCode == 200) {
      mapResponse = jsonDecode(response.body);
      if (mapResponse['status'] == 'success') {
        final snackBar = SnackBar(
          content: Text(mapResponse['message']),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (mapResponse['role'] == 'anggota') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePageUser()));
        } else if (mapResponse['role'] == 'admin') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePageAdmin()));
        }
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Login Failed"),
                content:
                    Text("invalid username or password. Please try again."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        usernameCtrl.clear();
                        passwordCtrl.clear();
                      },
                      child: Text("OK"))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          leading: null,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/150.png"),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(labelText: "Username"),
                    validator: (value) =>
                        value!.isEmpty ? "please fill out this form" : null,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )),
                    validator: (value) =>
                        value!.isEmpty ? "please fill out this form" : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login(usernameCtrl.text.trim(),
                              passwordCtrl.text.trim());
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
