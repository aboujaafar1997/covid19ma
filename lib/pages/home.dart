import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget {
  Map data={};
  Home({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(data['data'].length);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        backgroundColor: Colors.grey[800],
        elevation: 0,
        title: Text("لوحة البيانات", style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.right,),
        actions: <Widget>[
        ],
      ),
      body:CustomScrollView(
        slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: 140,
            delegate: SliverChildListDelegate([
              Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(data['data2']['recovering'].toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 30, fontWeight: FontWeight.bold),),
                      Text("شفاء", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(data['data2']['confirmed'].toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 30, fontWeight: FontWeight.bold),),
                      Text("حالة مؤكدة", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(data['data2']['deaths'].toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 30, fontWeight: FontWeight.bold),),
                      Text("وفايات", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
               SizedBox(width: 1,),
                ],
              ),
            ),
              Center(

                child:Text("معطيات المتوفرة لدينا حسب الجهات", style: TextStyle(color: Colors.white, fontSize: 23),)
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28,0,20,0),
                child: Table(

                    children: (data['data'] as List)
                        .map((item) => TableRow(children: [
                      Text(item['cases']==null?"0":item['cases'].toString()+"  : المجموع   ",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                      Text(item['newCases']==null?"+0":"   (حالة)   "+item['newCases'].toString(),style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                      Text(item['region']==null?" ":item['region'].toString(),style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),

                      // you can have more properties of course
                    ]))
                        .toList()
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("aboujaafar.othmane@gmail.com ", style: TextStyle(color: Colors.white, fontSize:12)),
                ],
              )
            ]),
          ),

        ],
      ),
    );
  }
}