// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testler/constant.dart';
import 'package:testler/models/person.dart';
import 'package:testler/utils/db_helper.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  String k = '';
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 19, fontWeight: FontWeight.w300);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: decoration('Person Name'),
                onChanged: (veri) {
                  k = veri;
                  setState(() {});
                },
              ),
            ),
            Container(
              height: 300,
              child: FutureBuilder<List<Person>>(
                future: DBHelper.instance.search(k),
                builder: (context, s) {
                  if (!s.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    if (s.data!.isEmpty) {
                      return Center(child: const Text('Veri Bulunamadı'));
                    } else {
                      return ListView.builder(
                        itemCount: s.data!.length,
                        itemBuilder: (context, i) {
                          var p = Person(
                              id: s.data![i].id,
                              ad: s.data![i].ad,
                              yas: s.data![i].yas,
                              sehir: s.data![i].sehir);
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              p.toString(),
                              style: style,
                            ),
                          ));
                        },
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  // return s.data!.isEmpty
                    //     ? Center(child: const CircularProgressIndicator())
                    //     : ListView.builder(
                    //         itemCount: s.data!.length,
                    //         itemBuilder: (context, i) {
                    //           var p = Person(
                    //               id: s.data![i].id,
                    //               ad: s.data![i].ad,
                    //               yas: s.data![i].yas,
                    //               sehir: s.data![i].sehir);
                    //           return Text(p.toString());
                    //         },
                    //       );