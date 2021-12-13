// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testler/constant.dart';
import 'package:testler/models/person.dart';
import 'package:testler/utils/db_helper.dart';

class InsertPage extends StatelessWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final _controller1 = TextEditingController();
    final _controller2 = TextEditingController();
    return Column(
      children: [
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
            onPressed: () {
              var p = Person(
                  ad: _controller.text,
                  yas: int.parse(_controller1.text),
                  sehir: _controller2.text);
              DBHelper.instance.add(p);
              FocusScope.of(context).unfocus();
            },
            child: Text('Insert Data'))
      ],
    );
  }
}
