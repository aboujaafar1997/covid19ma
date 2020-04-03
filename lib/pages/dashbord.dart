import 'package:flutter/material.dart';
import 'package:covid19ma/pages/home.dart';
import 'package:page_transition/page_transition.dart';

class dashbord extends StatefulWidget {
  @override
  _dashbordState createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> with TickerProviderStateMixin {
  Map data ={};
  PageController _pageController;

  AnimationController rippleController;
  AnimationController scaleController;

  Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
        initialPage: 0
    );

    rippleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    );

    scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Home(data: data)));
      }
    });

    rippleAnimation = Tween<double>(
        begin: 80.0,
        end: 90.0
    ).animate(rippleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rippleController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        rippleController.forward();
      }
    });

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(scaleController);

    rippleController.forward();
  }
  int totaleCases=0;
  int totaleDeath=0;
  @override
  Widget build(BuildContext context) {
    int s=0;
    int d=0;
    data = ModalRoute.of(context).settings.arguments;
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
    setState(() {
      totaleCases=s;
      totaleDeath=d;
    });
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          makePage(image: 'assets/virus'),
        ],
      ),
    );
  }
  Widget makePage({image}) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/virus.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.7),
                  ]
              )
          ),
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('كورونا بالمغرب', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(totaleCases.toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 40, fontWeight: FontWeight.bold),),
                    Text("حالة مؤكدة", style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(totaleDeath.toString(), style: TextStyle(color: Colors.yellow[400], fontSize: 40, fontWeight: FontWeight.bold),),
                    Text("وفايات", style: TextStyle(color: Colors.white, fontSize: 30),),
                  ],
                ),
                SizedBox(height: 150,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: rippleAnimation,
                    builder: (context, child) => Container(
                      width: rippleAnimation.value,
                      height: rippleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(.4)
                        ),
                        child: InkWell(
                          onTap: () {
                            scaleController.forward();
                          },
                          child: AnimatedBuilder(
                            animation: scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: scaleAnimation.value,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Text("اكتشف المزيد حول كورونا",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100),),
                ),
              ],
            ),
          ),
        )
    );
  }
}