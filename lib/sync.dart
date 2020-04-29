import 'package:flutter/material.dart';
import 'package:poshpotato/main.dart';
import 'display.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';
import 'credentials.dart';
import 'dart:convert';
import 'DisMov.dart';

class Sync extends StatefulWidget{
  @override
  _sync createState() =>new _sync();
}
 class _sync extends State<Sync>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(color: new Color(0xff000000)),
        child:Center(
          child:FlatButton (
            child: Text("SYNC NOW"),
            splashColor: Colors.redAccent,
            color: Colors.redAccent,
            onPressed: ()=> now(),
          ),
        ),
      ),
    );
  }


}

 now() async
{
  // init GSheets
  final gsheets = GSheets(credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(spreadsheetId);
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
      valve[cell[i][3]]={'title':"",'rating':'','desc':"",'img': "",'type':"" ,'qual':"",'episodes':{cell[i][1]:[[cell[i][0],cell[i][2]]]}};
      valve[cell[i][3]]['type']="mov";
      check.add(cell[i][3]);
      print(valve[cell[i][3]]);
      c=0;
    }
  }
  var js=json.encode(all);
  var st=js.toString();
  print(st);
  FileUtils.saveToFile(st);
  return valve;

}