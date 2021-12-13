// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testler/constant.dart';
import 'package:testler/models/person.dart';
import 'package:testler/utils/db_helper.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final _controller1 = TextEditingController();
    final _controller2 = TextEditingController();
    final _controller3 = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller3,
              decoration: decoration('İd'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: decoration('Ad'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller1,
              decoration: decoration('Yaş'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller2,
              decoration: decoration('Şehir'),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var p = Person(
                    id: int.parse(_controller3.text),
                    ad: _controller.text,
                    yas: int.parse(_controller1.text),
                    sehir: _controller2.text);
                await DBHelper.instance.update(p);
                FocusScope.of(context).unfocus();
              },
              child: Text('Update'))
        ],
      ),
    );
  }
}
