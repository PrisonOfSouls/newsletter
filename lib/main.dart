import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsletter/widgets.dart';
import 'package:provider/provider.dart';
import 'state.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => App()
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.filter_list_rounded,
                  color: Colors.cyan,
                  size: 30,
                ),
                title: const Text(
                    'News',
                    style: TextStyle(color: Colors.black)
                ),
                actionsIconTheme: IconThemeData(color: Colors.black),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () => {},
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => {},
                  ),
                ],
                bottom: const TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.cyan,
                  indicatorWeight: 4.0,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Text('Новые')),
                    Tab(icon: Text('Популярные')),
                    Tab(icon: Text('Подписки')),
                  ],
                ),
              ),
              body: Container(
                color: Colors.grey[400],
                child: TabBarView(
                    children: [
                      NewsNewTab(),
                      NewsPopularTab(),
                      NewsSubscriptionsTab()
                    ]
                ),
              )
          )
      ),
    );
  }
}