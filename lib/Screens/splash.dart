import 'package:flutter/material.dart';
import 'package:talika/Themes/theme.dart';

import '../Model/model.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String status="Loading";

  void refreshStatus(String s){
    setState(() {
      status=s;
    });
  }

  @override
  void initState(){
    _init();
    super.initState();
  }

  Future _init() async{
   var res=await _loadDatabase();
   if(res!=null) {
     messageShow(context,false, res);
   }
    _loadHome();
  }


  Future _loadDatabase() async{
    refreshStatus("Setting Up Database");
    await model.initdatabse();
    await model.gettasks();
  }

  _loadHome(){
    refreshStatus("Loading Home Screen");
     Navigator.pop(context);
     Navigator.of(context).pushNamed('home');
  }


  @override
  Widget build(BuildContext context) {
     var heigth=MediaQuery.of(context).size.height;
     var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: heigth,
        width: width,
        color: coltheme.background,
        child: Center(
          child: Container(
            height: heigth*0.4,
            width: width*0.6,
            padding: const EdgeInsets.all(30.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: coltheme.primarycolor,),
                const SizedBox(height: 15.0,),
                Text("$status...", style:coltheme.splashscreenfont),
              ],
            ),
          ),
        ),

      ),

    );
  }
}
