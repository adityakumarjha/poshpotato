import 'dart:io';
import 'main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DisplayPage extends StatelessWidget {
 var i;
 DisplayPage(  this.i);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home:Movie(i),
    );
  }
}

class Movie extends  StatefulWidget
{
  var i;

  Movie(  this.i );
  @override
  _moviemake createState()=>new _moviemake(i);}

  class _moviemake extends State<Movie>{
  var i;
  _moviemake(this.i);
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
                                    imageUrl:all[i]['img'])),
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
    ),


    ),

                    Row(

                      children:<Widget>[ Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0) ,
                          width: 270,
                        child: Text(all[i]['desc'],softWrap: true,style: TextStyle(color: Colors.blueAccent,),),
                         ),
                        OutlineButton(
                          child: Text("IMDB :8.5",style: TextStyle(color: Colors.yellowAccent,)),
                        )
                      ]),
              Container(
                  padding: const EdgeInsets.all(20),
                  width:200,
                  child:Center(
                child: new DropdownButton(items: [DropdownMenuItem(value: "1",child: Text("Season 1")),DropdownMenuItem(value: "1",child: Text("Season 1"))], onChanged: null)
              ))
                  ,Column(
                    children: list(i),

                  )

    ]
    )

    ));
  }

}
list(String i) {

  List listings = new List<Widget>();
  int j = 0;
  var len=all[i]['episodes']['2'].length;
  var srted=sort(i,'2');
  print(all[i]["title"]);
  print(len);
  //print("==//==/=/=/=/=/=/=/=/");
  for(j=0;j<len;j++)
    {

  listings.add(Container(
    height: 50,
      child: ListTile(
          title :Center(child :Text("Episode "+all[i]['episodes']['2'][j][1])),leading: Icon(Icons.play_circle_filled),trailing: Icon(Icons.file_download))));
  print(listings);
}
  return listings;
}

List<DropdownMenuItem> drop(String i)
{
   List<DropdownMenuItem> drop =new List();
//  int c=0;
//  for(int j=0;j<all.length;j++)
//  {
//    if(all[j].id==i)
//      c=j;
//  }
    for(int i=0;i<5;i++)
      {
        drop.add(
          DropdownMenuItem(
            value: i,
            child: Text('index=$i'),
          )
        );

      }
}

sort(var index,var a)
{
  for(int i=0;i<all[index]['episodes'][a].length;i++)
    {
      for(int j=i;j<all[index]['episodes'][a].length;j++)
      {
        if(int.parse(all[index]['episodes'][a][i][1])>int.parse(all[index]['episodes'][a][j][1]))
          {
            var temp=['0','0'];
            temp=all[index]['episodes'][a][i];
            all[index]['episodes'][a][i]=all[index]['episodes'][a][j];
            all[index]['episodes'][a][j]=temp;
          }
      }
    }

}