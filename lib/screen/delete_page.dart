// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testler/constant.dart';
import 'package:testler/utils/db_helper.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: decoration('Person İd'),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              DBHelper.instance.delete(int.parse(_controller.text));
              FocusScope.of(context).unfocus();
              _controller.clear();
            },
            child: Text('Delete'))
      ],
    );
  }
}
