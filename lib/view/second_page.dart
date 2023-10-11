import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  String? name, email;

  SecondPage({this.name, this.email});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Text("Name = ${widget.name}"),
        SizedBox(
          height: 20,
        ),
        Text("email = ${widget.email}"),
      ]),
    );
  }
}
