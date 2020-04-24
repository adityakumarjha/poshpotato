import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
void main() => runApp(MyApp());
var values=new List<List<String>>();
class data{
  String title;
  String id;
  var values=new List<String>();
  data(this.title,this.id,this.values);
}
List<data> all = new List<data>();

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
  var _credentials = r'''
{
 "type": "service_account",
  "project_id": "inspired-goal-274718",
  "private_key_id": "72f247b41f3cc7ce26359d66e29e50ccfcf83a52",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCo13wS+3HXaneQ\noISq/+X7y6i26C7k89g+x9tQzFKt7O5sXTRT+DLR6ESd1AvgvyzDqHV/iu0RiYai\nZhuwKel6Rm01aWbF6InroYfKSuwUO6yLc4lz2LSDiyDeK+YpgdGPMo3UfY9uFWAU\n9OCIT4vdLo8mzuVwSoEOY6krCtMrISpl1zfyS7z0/jaO+HpKGz26P6V7jwVvbLN9\nrJagtzJMoxSHhjuKQIFJwuQmjF0dEOYw1valmh1c9dPgwd0GbN25JGF3yCYz5N41\nEEGdhSud2BIAL2TFhBYvzT1qz/wfi95nY8QXnVkFVFv598roF2ChqGa6pht/guMp\nh3Y8qHNpAgMBAAECggEAEFmxu7ra1uQKCRjqUA7w7BXYVEIezHAquEWtYOEwfoRL\nwHW0LA+EiFxITMpsjgqlYJsvKbc/5utc/NwLgV9Fq2Ankj0PRUoUFRvy5O2ld/4h\nYu3A2VWagYSXHby9kLZwH0BjiLjSC3SJde4S0lB1uGkaVsVBZcLpRYX0K2VkdrAa\nghEISAwWl8UhYPPZ91WNbNlowgLyJGmNK8oonyorUMrHYAp7VG/1a6642sfVa1UH\nbalgF7T1G7gAB9kVs89jSHshjblMQrOtjDFsXqo3Pux8uJCgqwshD1drt+HralMG\nFv2iEXy+QcIl5h2dZNAAakHjRa97rhm7rz0x2ocV8wKBgQDoOxeJVOorbwMyNKeY\n08LYn9rjxZeuM9s7KzLU0fcLUkBbmmiAPpQfFOLRqa3b4hxm9srJ0cY7HKNt98QV\nuaNsCagprL3r/IqPJq5dJR2m+VlUUH8SL3+ZK+e3LcDlQ1LWU73RtrofA2cMW9qp\nl/GUmunVggXNNFN+b1lz9qej5wKBgQC6H3kOy6xePYajYPuCpGjcuh2Je+R/QL5m\n+8xADMwxlpuXT/0F+7F4yihQi+Mdh70vJlShcF/SK3aSC44+gCcVRzy5zkXd2BQs\nK3JOol8sBCALJtnXIIsriQe/gU3NNwEMB3pCXL2P3Xx2G91Lz62K6WMKffSdsa95\nBJtRpehELwKBgEB6R6qlnO66P9TssavI/8xNdeTPs7F2TGQ9NjvIoCLQj3XfhSw2\nM8H9doxn5BGs0d30n5ExYSyAYw/hPtwZUrpoY/xOLd0bnQzp3HeYGoeFq7uxLdbK\nwU6x1gASAACnlJRVY9qaNUrvEulnh2qW+UgdStcw5pN298ee+uMrlJf5AoGBAIk2\niK3Cs5lqbGboKaN/h5sqTno77xFtbrFHcqXJiYQJTz13B8cwbf7pslznNBFiL7Oh\n44R87vdneWtjv4MOQUHrmbY1fsZ09TI2+XdFNzqg8+qkwrZZVKBMznx9XBktMsVm\ngdiIvGtiUs5T7opkWcFuG8jxYLQc+YsTPVotIJWbAoGAWPUOx64zJMDL4pzDCglu\nT6RONztlcrO6g/53ArfjhMTQv12pq1sOM6b6fWUBn0+IxIE4/DP4Rcym+Wq78UHJ\nnQnwyPPIzCGqWoq/iGD0kGe0kUGTjNGShKqh5z0QJkRFPL+mqfDMjhhHP0UNmsS1\nIpIRqRiw+7RRPgvBcFhTW6U=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@inspired-goal-274718.iam.gserviceaccount.com",
  "client_id": "108128703971643406220",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40inspired-goal-274718.iam.gserviceaccount.com"
}
''';
  var _spreadsheetId = '1GSGl0KLWiKnMWnFKJ5JvTypfCLwevS9KrV8mdnayYPY';
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
    List<data> valve = new List<data>();
    List<String> go=new List();
    List<String> check=new List();
    int c=1;
    for(var i=0;i<cell.length;i++){
      c=1;
      for(int j=0;j<check.length;j++)
        {
          print(valve[j].values);
          c=1;
          if(check[j]==cell[i][3]){
            valve[j].values.add(cell[i][0]);
            c=0;
            break;
          }

        }
//      print(check);
//      print(c);
//      print(i);
      if(c==1)
        {
          valve.add(new data("abc",cell[i][3],[cell[i][0]]));
          check.add(cell[i][3]);
          c=0;
        }
    }

    all=valve;
    return values;

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
