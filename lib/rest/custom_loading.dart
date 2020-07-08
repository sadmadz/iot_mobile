import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iot/customfonts/font_awesome_flutter.dart';
import 'lottieIndicator.dart';

showLoading(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => WillPopScope(
          onWillPop: () {
          },
          child: new Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                child: new Container(
                    decoration: new BoxDecoration(
//                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0)),
                    width: 300.0,
                    height: 200.0,
                    alignment: AlignmentDirectional.center,
                    child: Card(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                              child: new Container(
                                height: 60.0,
                                width: 80.0,
                                child:
//                                LoaderIndicator(
//                                  dotOneColor: Colors.blue[900],
//                                  dotTwoColor: Colors.blue[900],
//                                  dotThreeColor: Colors.blue[900],
//                                  dotType: DotType.circle,
//                                  duration: Duration(milliseconds: 1200),
//                                ),
                            LottieIndicator("assets/animate/loading.json",height: 60,width: 60)
                        ),
                            ),

                            new Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: new Text(
                                message,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blueGrey[700],
                                    fontFamily: "VazirBold"),
                              ),
                            ),
                          ],
                        ))),
              ))));
}

showSuccessSnackBar(String message, BuildContext context) {
  Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.easeInSine,
      reverseAnimationCurve: Curves.easeOut,
      backgroundColor: Colors.green[500],
      animationDuration: Duration(milliseconds: 800),
      duration: Duration(seconds: 3),
      shouldIconPulse: false,
      padding: EdgeInsets.only(right: 8, top: 18, bottom: 18),
      icon: Icon(
        FontAwesomeIcons.infoCircle,
        size: 20,
        color: Colors.white,
      ),
//    title: "Hey Ninja",
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED)
    ..show(context);
}
