import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;

class Meme
{
   String id;
   String name;
   String url;
   Meme({this.id,this.name,this.url});
   factory Meme.fromJson(Map<String, dynamic> json) {
     return Meme(
       id: json['id'],
       name: json['name'],
       url: json['url'],
     );
   }
}