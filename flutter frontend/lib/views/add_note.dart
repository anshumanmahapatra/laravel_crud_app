import 'package:flutter/material.dart';

class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Flutter Laravel Crud'),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            child: TextFormField(),
          ),
          Container(
            child: TextFormField(),
          ),
        ],),
    );
  }
}
