import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
class Home extends StatelessWidget {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  List<CircularStackEntry> data0 = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        new CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];


  Map data={};
  Home({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    int s=0;
    int d=0;
    int p=0;
    int f=0;
    for(int i=0;i<data['data'].length;i++) {
      if(data['data'][i]['attributes']['Recoveries']!=null)
        p = p + int.parse(data['data'][i]['attributes']['Recoveries'].toString());
    }
    for(int i=0;i<data['data'].length;i++) {
      print(s);
      if(data['data'][i]['attributes']['Cases']!=null)
        s = s + int.parse(data['data'][i]['attributes']['Cases'].toString());
    }
    for(int i=0;i<data['data'].length;i++) {
      print(s);
      if(data['data'][i]['attributes']['Deaths']!=null)
        d = d + int.parse(data['data'][i]['attributes']['Deaths'].toString());
    }
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(p.toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 40, fontWeight: FontWeight.bold),),
                      Text("شفاء", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(s.toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 40, fontWeight: FontWeight.bold),),
                      Text("حالة مؤكدة", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(d.toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 40, fontWeight: FontWeight.bold),),
                      Text("وفايات", style: TextStyle(color: Colors.white, fontSize: 30),),
                    ],
                  ),
                ],
              ),
            ),
              Center(
                child:Text("معطيات حسب الجهات", style: TextStyle(color: Colors.white, fontSize: 30),)
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(28,0,20,0),
                child: Table(

                    children: (data['data'] as List)
                        .map((item) => TableRow(children: [
                      Text(item['attributes']["Cases"]==null?"0":item['attributes']["Cases"].toString()+"   (حالة)   ",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                      Text(item['attributes']["Recoveries"]==null?"0":item['attributes']["Recoveries"].toString()+"   (شفاء)   ",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                      Text(item['attributes']["Deaths"]==null?"0":item['attributes']["Deaths"].toString()+"   (وفاة)   ",style: TextStyle(color: Colors.white),textAlign: TextAlign.right,),
                      Text(item['attributes']["Nom_Région_AR"]==null?"0":item['attributes']["Nom_Région_AR"].toString()+"         ",style: TextStyle(color: Colors.yellow), textAlign: TextAlign.right,),
                      // you can have more properties of course
                    ]))
                        .toList()
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 20,),
              SizedBox(height: 20,),

            ]),
          ),
        ],
      ),
    );
  }
}