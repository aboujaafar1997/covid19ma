import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:get_ip/get_ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<Map> getPublicIP() async {
    try {
      const url = 'https://api.ipify.org';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var response2 = await http.get("http://ipinfo.io/${response.body}/geo");
        return jsonDecode(response2.body);
      } else {
        // The request failed with a non-200 code
        // The ipify.org API has a lot of guaranteed uptime
        // promises, so this shouldn't ever actually happen.
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      // Request failed due to an error, most likely because
      // the phone isn't connected to the internet.
      print(e);
      return null;
    }
  }
  void getdata() async {
   // String ipAddress = await GetIp.ipAddress;
 try{
   Map info = await getPublicIP();
   if(info!=null){
     await Firestore.instance.collection('users').document().setData({
       'date':new DateTime.now().toString(),
       'ip' : info['ip'],
       'country':info['country'],
       'city':info['city'],
       'region':info['region']
     });
     print("done!");
   }else{
     await Firestore.instance.collection('users').document().setData({
       'date':new DateTime.now().toString(),
       'ip' : 'unkow',
       'country':'unkow',
       'city':'unkow',
       'region':'unkow',
     });
   }
   //get data
   http.Response response2 = await http.get('https://covidma.herokuapp.com/api');
   List<dynamic> data2 = jsonDecode(response2.body);
   //test
   if(data2!=null){
     Future.delayed(Duration(seconds: 2),(){
       Navigator.pushReplacementNamed(context, '/dashbord', arguments: {
         'data2':data2[0],
         'data':data2[1],
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

 }catch(e){
   showDialog(
       context: context,
       builder: (context) => AlertDialog(
         title: Text("Error"),
         content: Text("Ckeck you connection or probleme with server"),
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