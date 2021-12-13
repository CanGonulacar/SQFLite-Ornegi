// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testler/models/person.dart';
import 'package:testler/utils/db_helper.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
    return FutureBuilder<List<Person>>(
      future: DBHelper.instance.getPerson(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return snapshot.data!.isEmpty
              ? Center(child: Text('Veri Yok'))
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    var veri = snapshot.data![i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '[${veri.id}] Adı: ${veri.ad}, Yaşı: ${veri.yas}, Şehir: ${veri.sehir}',
                          style: style,
                        ),
                      ),
                    );
                  },
                );
        }
      },
    );
  }
}
