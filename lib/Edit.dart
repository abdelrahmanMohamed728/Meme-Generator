import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'meme.dart';

class Edit extends StatefulWidget {
  String id;

  Edit(this.id);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditState(id);
  }
}

class _EditState extends State<Edit> {
  String id;
  String text1 = " ";
  String text2 = " ";
  String url = " ";

  _EditState(this.id);

  Future<String> makeRequest() async {
    var response = await http.post(
        Uri.encodeFull('https://api.imgflip.com/caption_image?template_id=' +
            id +
            '&username=abdomohamed&password=thegame728&text0=' +
            text1 +
            '&text1=' +
            text2),
        body: json.encode({}),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        });
    if (response.statusCode == 200) {
      print('yes');

      setState(() {
        var map = json.decode(response.body);
        url = map['data']['url'].toString();
      });

      print(url);
    } else
      print('No');
  }

  @override
  void initState() {
    makeRequest();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.photo),
            title: Text('Home Of Memes'),
          ),
          body: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (text) {
                    setState(() {
                      text1 = text;
                    });
                  },
                ),
                TextField(
                  onChanged: (text) {
                    setState(() {
                      text2 = text;
                    });
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    makeRequest();
                  },
                  child: Text("Edit"),
                ),
                Container(
                  child: Image.network(url, height: 300, width: 300),
                  margin: EdgeInsets.only(top: 20),
                )
              ],
            ),
          )),
    );
  }
}
