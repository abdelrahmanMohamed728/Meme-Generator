import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'meme.dart';
import 'Edit.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homeState();
  }
}

class _homeState extends State<Home> {
  List<Meme> list;

  Future getData() async {
    http.Response response =
        await http.get('https://api.imgflip.com/get_memes');
    var map = json.decode(response.body);

    setState(() {
      list =
          (map['data']['memes'] as List).map((p) => Meme.fromJson(p)).toList();
    });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.photo),
            title: Text('Home Of Memes'),
          ),
          body: new Column(
            children: <Widget>[
              new Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, i) {
                        return Container(
                            margin: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              child: Image.network(
                                  list[i].url,
                                  height: 200, width: 100),
                              onDoubleTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new Edit(list[i].id)));
                              },
                            ));
                      }))
            ],
          )),
    );
  }
}
