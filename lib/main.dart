import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'package:flutter/services.dart';
void main() => runApp(Posh());

class Posh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
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
                  Tab(icon: Icon(Icons.movie,), text: "Movies",),
                  Tab(icon: Icon(Icons.tv), text: "TV"),
                  Tab(icon: Icon(Icons.favorite), text: "Favourates"),
                  Tab(icon: Icon(Icons.search), text: "Search"),
                ],
                unselectedLabelColor: Colors.tealAccent,
                labelColor: Colors.white,
                indicatorColor: Colors.transparent
            ),
            body: TabBarView(
              children: [
                HomePage(),
                Center( child: Text("TV")),
                Center( child: Text("Favourates"),),
                Center( child: Text("Search")),
              ],
            ),
          ),
        )
    );
  }
}