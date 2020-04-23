import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
void main() => runApp(MyApp());
var values=new List<List<String>>();
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
    );
  }
}
class Start extends StatefulWidget {
  @override
  _startState createState() => new _startState();
}

class _startState extends State<Start> {

@override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _id(),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return wait(context, snapshot);
        if(snapshot.connectionState==ConnectionState.waiting)
          return Posh(context, snapshot);
        if(snapshot.connectionState==ConnectionState.none)
          return MaterialApp(
            home :Scaffold(
            body:Center(
            child: Text("none")
        )));
        else
          return MaterialApp(
              home :Scaffold(
                  body:Center(
                      child: Text("Error")
                  )));

      }
    );

  }

 Future _id() async {
   var val=new List<List<String>>();
    // init GSheets
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet =  ss.worksheetByTitle('Sheet1');
    var cell = await sheet.values.allRows(fromColumn: 4, fromRow: 2);
    for(var i=0;i<cell.length;i++){
      print(cell.length);
    val.add(cell[i]);}
    values=val;
    return val;

    // get worksheet by its title
  }

  Widget wait(BuildContext context, AsyncSnapshot snapshot) {
    return DefaultTabController(
        length: 4,
        child: Theme(
          data: ThemeData(
              brightness: Brightness.dark
          ),
          child: Scaffold(
            backgroundColor: Colors.black,
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
                Center(child: Text("TV")),
                Center(child: Text("Favourates"),),
                Center(child: Text("Search")),
              ],
            ),
          ),
        )
    );
  }

  Widget Posh(BuildContext context, AsyncSnapshot snapshot) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark
      ),
        home: Scaffold(
          backgroundColor: Colors.black,
            body: Container(

              child: Center(
                child:Icon(Icons.adb,color: Colors.tealAccent,size: 250,),

              ),
            )));
  }
}
