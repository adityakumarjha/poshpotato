import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshpotato/main.dart';
import 'homepage.dart';
import 'package:poshpotato/videop.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisplayMov extends StatelessWidget {
  String id;
  DisplayMov(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            child :ListView(
                shrinkWrap: true,
                children:<Widget>[
            Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            height: 350,
            width: 200,
            child: new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children:<Widget>
                [ClipRRect(borderRadius:BorderRadius.circular(16.0),
                      child :CachedNetworkImage(
                          imageUrl:all[id]['img'])),
                  Container(
                      child: new FlatButton(
                        child: Container(
                            child:Icon(Icons.favorite,color: Colors.white,size: 60,)),
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
    )),Row(

                      children:<Widget>[ Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0) ,
                        width: 260,
                        child: Text(all[id]['desc'],softWrap: true,style: TextStyle(color: Colors.blueAccent,),),
                      ),
                        OutlineButton(
                          child: Text("IMDB :${all[id]['rating']}",style: TextStyle(color: Colors.yellowAccent,)),
                        )
                      ]),]
            )
        )
    );

    }
}