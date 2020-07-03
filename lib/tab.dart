import 'package:flutter/material.dart';
import 'list.dart';
import 'listPerson.dart';
import 'listplc.dart';


class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Text("Place")),
                Tab(icon: Text("People")),               
                Tab(icon: Text("Auto-Record")),
              ],
            ),
            title: Text('My Contacts'),
          ),
          body: TabBarView(
            children: [
              Place(),
              ListPagePerson(),
              ListPage(),
            ],
          ),
        ),
      ),
    );
  }
}