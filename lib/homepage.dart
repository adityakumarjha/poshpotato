import 'package:flutter/material.dart';
import 'display.dart';
import 'package:get/get.dart';
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class HomePage extends StatelessWidget {
  @override
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

List _getchildren() {
  List listings = new List<Widget>();
  int i = 0;
  for (i = 0; i < 50; i++) {
    listings.add(
       InkWell(
      child:Container(
        //padding: const EdgeInsets.all(8),
          height: 100,
          width: 100,
          color:const Color(0x33000066),
          child: new Image.asset('assets/images/westworld.jpg',fit: BoxFit.fill)
      ),
         onTap: ()=>Get.to(DisplayPage()),

      ),

    );
  }
  return listings;
}



class View extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Scaffold(
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