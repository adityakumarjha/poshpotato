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
                                child :new Image.asset('assets/images/tbbt.jpg',fit: BoxFit.fill)),
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
                    margin: const EdgeInsets.only(left: 90.0, right: 20.0) ,
                    padding: const EdgeInsets.all(20),
                    child :Row(
                            children: <Widget>[
                               OutlineButton(
                                 child: Text('480p',style: TextStyle(color: Colors.purpleAccent),),
                                  ),
                               OutlineButton(
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


