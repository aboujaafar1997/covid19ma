import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:http/http.dart';
import 'dart:convert';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getdata() async {
    //get data
    Response response2 = await get('https://covidma.herokuapp.com/api');
    Response response = await get('https://services3.arcgis.com/hjUMsSJ87zgoicvl/arcgis/rest/services/Covid_19/FeatureServer/0/query?where=1%3D1&outFields=*&outSR=4326&f=json');
    Map data = jsonDecode(response.body);
    List<dynamic> data2 = jsonDecode(response2.body);
    //test
    if(data!=null){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacementNamed(context, '/dashbord', arguments: {
          'data':data['features'],
          'data2':data2[0],
        });
      });
    }else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text("Ckeck you connection"),
            actions: [
              new FlatButton(
                child: const Text("Ok"),
                onPressed: (){
                  SystemNavigator.pop();
                },
              ),
            ],
          ));
    }

  }
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

        backgroundColor: Colors.grey[900],
        body:
        Center(
            child:Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 20.0),
                SpinKitFoldingCube(
                  color: Colors.white,
                  size: 50.0,
                ),
                Text("Powered by othmane aboujaafar",style: TextStyle(color: Colors.white,fontSize: 20)),
              ],
            )
        )
    );
  }
}