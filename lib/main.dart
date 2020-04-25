import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
void main() => runApp(MyApp());
var values=new List<List<String>>();

Map all = new Map();

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

    // init GSheets
    final gsheets = GSheets(_credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final sheet =  ss.worksheetByTitle('Sheet1');
    var cell = await sheet.values.allRows(fromColumn: 4, fromRow: 2);
    Map valve=new Map();
    List<String> check=new List();
    int c=1;
    for(var i=0;i<cell.length;i++){
      c=1;
      for(int j=0;j<check.length;j++)
        {

          c=1;
          if(check[j]==cell[i][3]){
            valve[cell[i][3]]['episodes'][cell[i][1]].add([cell[i][0],cell[i][2]]);
            valve[cell[i][3]]['type']="tv";
            c=0;
            break;
          }

        }
      print(check);
//      print(c);
//      print(i);
      if(c==1)
        {
          valve[cell[i][3]]={'title':"",'desc':"",'img': "",'type':"" ,'qual':"",'episodes':{cell[i][1]:[[cell[i][0],cell[i][2]]]}};
          valve[cell[i][3]]['type']="mov";
          check.add(cell[i][3]);
          print(valve[cell[i][3]]);
          c=0;
        }
    }

    all=valve;
    return valve;

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
