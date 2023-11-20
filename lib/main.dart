import 'package:flutter/material.dart';

void main() => runApp(IKBook());

class IKBook extends StatefulWidget {
  const IKBook({super.key});

  @override
  State<IKBook> createState() => _IKBookState();
}

class _IKBookState extends State<IKBook> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("IK Book")),
        body: Container(
          color: Colors.purple,
          width: 100,
          height: 100,
        ));
  }
}
