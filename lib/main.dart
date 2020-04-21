import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';

void main() => runApp(Posh());

class Posh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: AppTabBar(),
    );
  }
}
class AppTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Theme(
          data: ThemeData(
              brightness: Brightness.dark
          ),
          child: Scaffold(
            backgroundColor:  Colors.black ,
            bottomNavigationBar: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home,), text: "Home",),
                  Tab(icon: Icon(Icons.search), text: "Search"),
                  Tab(icon: Icon(Icons.file_download), text: "Downloads"),
                  Tab(icon: Icon(Icons.list), text: "Settings"),
                ],
                unselectedLabelColor: Colors.tealAccent,
                labelColor: Colors.white,
                indicatorColor: Colors.transparent
            ),
            body: TabBarView(
              children: [
                HomePage(),
                Center( child: Text("Search")),
                Center( child: Text("Downloads"),),
                Center( child: Text("Settings")),
              ],
            ),
          ),
        )
    );
  }
}