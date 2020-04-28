import 'dart:io';
import 'main.dart';
import 'package:file_utils/file_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'credentials.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
var id;
class DisplayPage extends StatelessWidget {
 var i;
 DisplayPage(  this.i);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
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

  class _moviemake extends State<Movie>  with AutomaticKeepAliveClientMixin<Movie> {
    var dio = Dio();
    var i;
    var col;
    var dropvalue;
  void initState() {
    col=Colors.white;
    _portraitModeOnly();
    if(liked.contains(i))
      col=Colors.red;
  }

  @override
  _moviemake(this.i){
    _portraitModeOnly();
   all[i]['episodes'].forEach((k,v){
      print(k);
      dropvalue=k;
      return k;
    });
  }
    bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Container(
            child :ListView(
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
                                    imageUrl:all[i]['img'])),
                              Container(
                                child: new FlatButton(
                                  child: Container(
                                      child:Icon(Icons.favorite,color: col,size: 60,)),
                                        onPressed:()=>{setState((){col=Colors.red;like(i);})},
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
                          width: 260,
                        child: Text(all[i]['desc'],softWrap: true,style: TextStyle(color: Colors.blueAccent,),),
                         ),
                        OutlineButton(
                          onPressed: ()=>{lan("https://www.imdb.com/title/$i/")},
                          child: Text("IMDB:${all[i]['rating']}",style: TextStyle(color: Colors.yellowAccent,)),
                        )
                      ]),
              Container(
                  padding: const EdgeInsets.all(20),
                  width:10,
                  child:Container(
                      margin: const EdgeInsets.only(left: 155.0, right: 10.0) ,
                child: new DropdownButton(underline:Container(height: 0,color: Colors.black,),elevation: 16,style:TextStyle(color: Colors.purpleAccent) ,value: dropvalue,onChanged: (newValue) {
                  setState(() {
                    dropvalue = newValue;
                  });
                },items:drop(i), )
              ))
                  ,Container(
                    child: Column(

                      children: list1(i,dropvalue),
                    ),
                  )

    ]
    )

    ));
  }

    @override
    void dispose() {
      super.dispose();
      _enableRotation();
    }
}
//list(String i,var dio) {
//
//  List listings = new List<Widget>();
//  int j = 0;
//  var len=all[i]['episodes']['2'].length;
//  sort(i,'2');
//  print(all[i]["title"]);
//  print(len);
//  //print("==//==/=/=/=/=/=/=/=/");
//  for(j=0;j<len;j++)
//    {
//    print(all[i]['episodes']['2'][j]);
//  listings.add(Container(
//    height: 50,
//      child: ListTile(
//          title :Container(margin: const EdgeInsets.only(left: 20.0, right: 0.0) ,child:Center(child :Text("Episode "+all[i]['episodes']['2'][j][1]))),leading: FlatButton(child:Icon(Icons.play_circle_filled,size: 30,), color: Colors.blueAccent,key:all[i]['episodes']['2'][j][0] ,onPressed:() =>launch('https://www.googleapis.com/drive/v2/files/$key?alt=media&key=$gapi'),),trailing: FlatButton(child :Icon(Icons.file_download,size: 30,),color: Colors.blueAccent,onPressed: ()=> {lan(link('${all[i]['episodes']['2'][j][0]}'))}))));
//  print(listings);
//}
//  return listings;
//}

List<DropdownMenuItem> drop(String i)
{
   List<DropdownMenuItem> drop =new List();
//  int c=0;
//  for(int j=0;j<all.length;j++)
//  {
//    if(all[j].id==i)
//      c=j;
//  }
  all[i]['episodes'].forEach((k,v)
      {
        drop.add(
          DropdownMenuItem(
            value: k.toString(),
            child: Text('Season $k'),
          )
        );

      });
    return drop;
}

sort(var index,var a)
{
  for(int i=0;i<all[index]['episodes'][a].length;i++)
    {
      for(int j=i;j<all[index]['episodes'][a].length;j++)
      {
        if(int.parse(all[index]['episodes'][a][i][1])>int.parse(all[index]['episodes'][a][j][1]))
          {
            var temp;
            temp=all[index]['episodes'][a][i];
            all[index]['episodes'][a][i]=all[index]['episodes'][a][j];
            all[index]['episodes'][a][j]=temp;
          }
      }
    }

}

link(String a)
{
  return "https://www.googleapis.com/drive/v2/files/$a?alt=media&key=$gapi";
}

Future down(Dio dio, String url) async {
  String i='1';
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  CancelToken cancelToken = CancelToken();
  try {
    await dio.download("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.viz.com%2Fone-punch-man&psig=AOvVaw2v2k0E0r0dCtA_fB0xP2fR&ust=1587925746979000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNjX08KahOkCFQAAAAAdAAAAABAD", "downloads/abcd.jpg",
        onReceiveProgress: showDownloadProgress, cancelToken: cancelToken);
  } catch (e) {
    print(e);
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

dos() async{
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    return dio;
}

//down1(String url) async{
//  Map<String, String> requestHeaders = {
//    'Authorization': 'Bearer ' + http.cookie,
//  };
//
//  String i='1';
//  Directory appDocDir = await getApplicationDocumentsDirectory();
//  String appDocPath = appDocDir.path;
//  final assetsDir = appDocPath + '/';
//  final taskId = await appDocPath.enqueue(
//    url: url,
//    savedDir: assetsDir,
//    fileName: i,
//    headers: requestHeaders,
//    showNotification: true, // show download progress in status bar (for Android)
//    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//  );
//}


downloadFile(String url, {String filename}) async {
  url="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.viz.com%2Fone-punch-man&psig=AOvVaw2v2k0E0r0dCtA_fB0xP2fR&ust=1587925746979000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNjX08KahOkCFQAAAAAdAAAAABAD";
  var httpClient = http.Client();
  var request = new http.Request('GET', Uri.parse(url));
  var response = httpClient.send(request);
  String dir = (await getApplicationDocumentsDirectory()).path;

  List<List<int>> chunks = new List();
  int downloaded = 0;

  response.asStream().listen((http.StreamedResponse r) {

    r.stream.listen((List<int> chunk) {
      // Display percentage of completion
      debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

      chunks.add(chunk);
      downloaded += chunk.length;
    }, onDone: () async {
      // Display percentage of completion
      debugPrint('downloadPercentage: ${downloaded / r.contentLength * 100}');

      // Save the file
      File file = new File('$dir/abc1234');
      final Uint8List bytes = Uint8List(r.contentLength);
      int offset = 0;
      for (List<int> chunk in chunks) {
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      await file.writeAsBytes(bytes);
      return;
    });
  });
}


list1(String i,String dvalue)
{
  List listings = new List<Widget>();
  sort(i,dvalue);
for(int j=0;j<all[i]['episodes'][dvalue].length;j++){
  listings.add(
    Row(
      children: <Widget>[
        Container(
          width: 50,
          child: FlatButton(
            child:Icon(Icons.play_arrow,size: 50,color: Colors.blueAccent,) ,onPressed:()=>Get.to(VideoApp('https://www.googleapis.com/drive/v2/files/${all[i]['episodes'][dvalue][j][0]}?alt=media&key=$gapi')) ,),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 10.0) ,
          width: 300,
          child: Center(child :Text("Episode "+all[i]['episodes'][dvalue][j][1])),
        )
        ,
        Container(
          width: 50,
          child: FlatButton(
            child:Icon(Icons.file_download,size: 50,color: Colors.blueAccent,) ,onPressed:()=>launch('https://www.googleapis.com/drive/v2/files/${all[i]['episodes'][dvalue][j][0]}?alt=media&key=$gapi') ,),
        )
      ],
    )

  );

}
return listings;
}
void _enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
mixin PortraitStatefulModeMixin<T extends StatefulWidget> on State<T> {
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return null;
  }
}