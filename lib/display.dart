import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'package:get/get.dart';
class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home:Movie(),
    );
  }
}

class Movie extends  StatefulWidget
{
  @override
  _MovieState createState()=>_MovieState();}

  class _MovieState extends State<Movie>
{
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body:
          Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 110.0, right: 20.0),
                height: 350,
                  width: 200,
                  child: new Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:<Widget> [ClipRRect(borderRadius:BorderRadius.circular(16.0),
                      child :new Image.asset('assets/images/westworld.jpg',fit: BoxFit.fill)),
                      Container(
                         child: new FlatButton(
                              child: Container(
                                  child:Icon(Icons.play_circle_filled,color: Colors.black54,size: 60,)),
                              onPressed:()=>Get.to(Video()),
                          )
                      )

              ]))

            ],
          ),

// we can change to be backgr


    );
  }

}


