import 'package:flutter/material.dart';
import 'homepage.dart';
class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.dark
      ),
      home:Center( child: Text("Page 2")),
    );
  }
}


