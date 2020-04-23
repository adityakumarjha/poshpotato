import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
class DisplayPage extends StatelessWidget {
 String  img='';
 DisplayPage(String i)
 {
   img=i;
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home:Movie(img),
    );
  }
}

class Movie extends  StatefulWidget
{
  String img;
  Movie(String i)
  {
    img=i;
  }
  @override
  _MovieState createState()=>_MovieState(img);}

  class _MovieState extends State<Movie>
{
  String img;
  _MovieState(String i)
  {
    img=i;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Container(
            child :Column(
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
    )

    ]
    )

    ));
  }

}


