import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'credentials.dart';
import 'sync.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
void main() async{

  runApp(MyApp());}
var values=new List<List<String>>();

Map all = new Map();
var liked=['123'];

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      //debugShowCheckedModeBanner: false,
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
//  void initState() {
//    _getThing().then((value){
//      print('Async done');
//    });
//    super.initState();
//  }

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
//  if(all.length!=0)
//    return all;
    // init GSheets
    final gsheets = GSheets(credentials);
    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(spreadsheetId);
    final sheet =  ss.worksheetByTitle('Sheet1');
    var cell = await sheet.values.allRows(fromColumn: 4, fromRow: 2);
    Map valve=new Map();
    List<String> check=new List();
    int c=1;
    print(cell.length);
    for(var i=0;i<cell.length;i++){
      c=1;
      for(int j=0;j<check.length;j++)
        {

          c=1;
          if(check[j]==cell[i][3]){
            print(valve[cell[i][3]]['episodes'].containsKey(cell[i][1]));
            if(valve[cell[i][3]]['episodes'].containsKey(cell[i][1])==true){
            valve[cell[i][3]]['episodes'][cell[i][1]].add([cell[i][0],cell[i][2]]);
            valve[cell[i][3]]['type']="tv";}
            if(valve[cell[i][3]]['episodes'].containsKey(cell[i][1])==false)
              valve[cell[i][3]]['episodes'][cell[i][1]]=[[cell[i][0],cell[i][2]]];
            c=0;
            print(valve);
            break;
          }

        }
      //print(check);
//      print(c);
//      print(i);
      if(c==1)
        {
          valve[cell[i][3]]={'title':"",'rating':'','desc':"",'img': "",'type':"" ,'qual':"",'episodes':{cell[i][1]:[[cell[i][0],cell[i][2]]]}};
          if(cell[i][1]=='0')
          valve[cell[i][3]]['type']="mov";
          else
            valve[cell[i][3]]['type']="tv";
          check.add(cell[i][3]);
          print(cell[i][3]);
          c=0;
        }
    }
    var js=json.encode(all);
    var st=js.toString();
    print(st);
    FileUtils.saveToFile(st);
    all=valve;
    return valve;

    // get worksheet by its title
  }

  _getThing() async{
  all=json.decode(await FileUtils.readFromFile());
  //print(all);
 // print("????????????????????????????????/");

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
                  Tab(icon: Icon(Icons.favorite), text: "Favourates"),
                  Tab(icon: Icon(Icons.search), text: "Search"),
                  Tab(icon: Icon(Icons.sync), text: "Sync "),
                ],
                unselectedLabelColor: Colors.tealAccent,
                labelColor: Colors.white,
                indicatorColor: Colors.transparent,

            ),
            body: TabBarView(
              children: [
                HomePage(),
                Center(child: Text("Favourates")),
                Center(child: Text("Search"),),
                Sync(),
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




class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/myfile.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    return file.writeAsString(data);
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }
}

