import 'package:flutter/material.dart';
import 'package:ik_book/user/homepage.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
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
                  Center(child: Image.asset("assets/150.png")),
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
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (usernameCtrl.text == 'user' &&
                              passwordCtrl.text == "123") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Login Failed"),
                                    content: Text(
                                        "invalid username or password. Please try again."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text("Login"))
                ],
              )),
        ));
  }
}
