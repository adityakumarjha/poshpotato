import 'package:flutter/material.dart';
import 'package:poshpotato/main.dart';
import 'display.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';
import 'dart:convert';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class HomePage extends StatefulWidget {
  @override
  _Page createState()=>_Page();}
class Album {
  final String img;
  final String Title;

  Album({this.img,  this.Title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      img: json['Poster'],
      Title: json['Title'],
    );
  }
}

class _Page extends State<HomePage> {

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home: View(),
    );
  }
}
List _listings = new List();
List<String> ch=['assets/images/westworld.jpg','assets/images/tbbt.jpg'];

 _getchildren() {
  List listings = new List<Widget>();
  int i = 0;
  int len=values.length;
  print(values);
  print(len);
  for (i = 0; i < values.length; i++) {
    var f=values[i][1];
    Future<Album> fetchAlbum() async {
      final response= await http.get('http://www.omdbapi.com/?i=$f&apikey=ed6be837');
      if (response.statusCode == 200) {
        return Album.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load album');

      }
    }

//    print(img);
    var futureAlbum = fetchAlbum();
    //var pos=json.decode(futureAlbumimg);
    listings.add(

        Container(
          //padding: const EdgeInsets.all(8),
            height: 100,
            width: 100,
            color:const Color(0x33000066),
            child: ClipRRect(borderRadius:BorderRadius.circular(16.0),
                child :
                FutureBuilder<Album>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        child:CachedNetworkImage(
                            imageUrl:snapshot.data.img) ,
                        onTap: ()=>Get.to(DisplayPage(snapshot.data.img)),
                        onDoubleTap: (){print(values);},
                      );
                    } else if (snapshot.hasError) {
                      return Text("error");
                    }

                    // By default, show a loading spinner.
                    return Text(snapshot.data.Title);
                  },
                ),
            ),
              ),


      );

  }
  return listings;
}



class View extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,title: Center(child:const Text('Posh Potato')),) ,
      body: Container(
          decoration: new BoxDecoration(color: new Color(0xff000000)),
          child: new GridView.count(primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 2/3,
              children:
              _getchildren())),


    );
  }
}