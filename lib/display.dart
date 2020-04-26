import 'dart:io';
import 'main.dart';
import 'package:file_utils/file_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poshpotato/videop.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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

  class _moviemake extends State<Movie>  with AutomaticKeepAliveClientMixin<Movie> {
    var dio = Dio();
    var dropvalue='2';
  var i;

  _moviemake(this.i);
    bool get wantKeepAlive => true;
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
                                    imageUrl:all[i]['img'])),
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
                  width:200,
                  child:Center(
                child: new DropdownButton(underline:Container(height: 0,color: Colors.black,),elevation: 16,style:TextStyle(color: Colors.purpleAccent) ,value: dropvalue,onChanged: (newValue) {
                  setState(() {
                    dropvalue = newValue;
                  });
                },items:drop(i), )
              ))
                  ,Column(
                    children: list(i,dio),

                  )

    ]
    )

    ));
  }

}
list(String i,var dio) {

  List listings = new List<Widget>();
  int j = 0;
  var len=all[i]['episodes']['2'].length;
  sort(i,'2');
  print(all[i]["title"]);
  print(len);
  //print("==//==/=/=/=/=/=/=/=/");
  for(j=0;j<len;j++)
    {
    print(all[i]['episodes']['2'][j]);
  listings.add(Container(
    height: 50,
      child: ListTile(
          title :Center(child :Text("Episode "+all[i]['episodes']['2'][j][1])),leading: Icon(Icons.play_circle_filled),trailing: FlatButton(child :Icon(Icons.file_download),onPressed: ()=> {lan(link(all[i]['episodes']['2'][0][0]))}))));
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
  return "https://www.googleapis.com/drive/v2/files/$a?alt=media&key=AIzaSyAzmkNUwmTLpwQNmTT5UKMQ1AftcVBJ7D4";
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

lan(var url) async{
  launch(url);
}