import 'package:covid19ma/pages/Loading.dart';
import 'package:covid19ma/pages/dashbord.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: "/",
  routes: {
    '/':(context)=>Loading(),
    '/home':(context)=>Home(),
    '/dashbord':(context)=>dashbord(),
  },
));

