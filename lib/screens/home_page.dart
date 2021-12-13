import 'package:flutter/material.dart';
import 'package:testler/screens/delete_page.dart';
import 'package:testler/screens/insert_page.dart';
import 'package:testler/screens/query_page.dart';
import 'package:testler/screens/update_page.dart';
import 'package:testler/screens/view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = TabController(length: 5, vsync: this);
    return Scaffold(
      appBar: AppBar(
        bottom: _tabBar(controller),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          InsertPage(),
          ViewPage(),
          QueryPage(),
          DeletePage(),
          UpdatePage()
        ],
      ),
    );
  }

  TabBar _tabBar(TabController controller) {
    final _tabs = <Tab>[
      const Tab(text: 'Insert', icon: Icon(Icons.add)),
      const Tab(text: 'View', icon: Icon(Icons.view_list_outlined)),
      const Tab(text: 'Query', icon: Icon(Icons.search_rounded)),
      const Tab(text: 'Delete', icon: Icon(Icons.delete)),
      const Tab(text: 'Update', icon: Icon(Icons.edit)),
    ];
    return TabBar(
      controller: controller,
      tabs: _tabs,
    );
  }
}
