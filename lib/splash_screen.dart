import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot/home_screen.dart';
import 'package:iot/rest/lottieIndicator.dart';

import 'global.dart';
import 'network/home_api.dart';
import 'network/type_api.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  getTypes() async {
    TypeApi typeApi = new TypeApi();
    typeApi.getTypes().then((_response) {
      if (_response != null) {
        Global.types.clear();
        Global.types.addAll(_response);
        getHomes();
      } else {
        getTypes();
      }
    }).catchError((onError) {
      print("_response");
      print(onError);
      getTypes();
    });
  }

  getHomes() async {
    HomeApi homeApi = new HomeApi();
    homeApi.getHomes().then((_response) {
      if (_response != null) {
        Global.homes.clear();
        Global.homes.addAll(_response);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        getTypes();
      }
    }).catchError((onError) {
      print("_response");
      print(onError);
      getTypes();
    });
  }

  @override
  void initState() {
    super.initState();
    getTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child:
          LottieIndicator("assets/animate/loading.json", height: 80, width: 80),
    );
  }
}
