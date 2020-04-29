import 'dart:io';
import 'main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DisplayPage extends StatelessWidget {
 var  img;
 var i;
 DisplayPage( this.img, this.i);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home:Movie(img,i),
    );
  }
}

class Movie extends  StatefulWidget
{
  var img;
  var i;

  Movie( this.img, this.i );
  @override
  _moviemake createState()=>new _moviemake(img,i);}

  class _moviemake extends State<Movie>{
  var img,i;
  _moviemake(this.img,this.i);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Container(
            child :ListView(
              shrinkWrap: true,
                children:<Widget>[
                    Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        height: 350,
                        width: 200,
                        child: new Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children:<Widget>
                              [ClipRRect(borderRadius:BorderRadius.circular(16.0),
                                child :CachedNetworkImage(
                                    imageUrl:img)),
                              Container(
                                child: new FlatButton(
                                  child: Container(
                                      child:Icon(Icons.play_circle_filled,color: Colors.white,size: 60,)),
                                        onPressed:()=>Get.to(Video()),
                      )
                  ),

                ]

            )
        ),
                  Container(
                    margin: const EdgeInsets.only(left: 93.0, right: 20.0) ,
                    padding: const EdgeInsets.all(20),
                    child :Row(
                            children: <Widget>[
                               OutlineButton(
                                 child: Text('480p',style: TextStyle(color: Colors.purpleAccent),),
                                  ),
                               OutlineButton(
                                 onPressed:() => null ,
                                 child: Text('720p', style: TextStyle(color: Colors.purpleAccent),),

                                  )
                            ]
    )
    ),
              Container(
                child: new DropdownButton(items: [DropdownMenuItem(value: "1",child: Text("Season 1")),DropdownMenuItem(value: "1",child: Text("Season 1"))], onChanged: null)
              )
              ,Column(
                    children: list(i),

                  )

    ]
    )

    ));
  }

}
list(String i) {

  print(i);
  int c;
  for(int j=0;j<all.length;j++)
    {
      if(all[j].id==i)
        c=j;
    }
  List listings = new List<Widget>();
  int j = 0;
  var len=all[c].episodes['2'].length;
  print(len);
  //print("==//==/=/=/=/=/=/=/=/");
  for(j=1;j<len;j++)
    {
  listings.add(Container(
    height: 50,
      child: ListTile(
          title :Center(child :Text(all[c].episodes['2'][j][0])),leading: Icon(Icons.play_circle_filled),trailing: Icon(Icons.file_download))));
  print(listings);
}
  return listings;
}


