import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieIndicator extends StatelessWidget {
  String src;
  double height,width;

  LottieIndicator(this.src,{this.height,this.width
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(this.src, height: this.height, width: this.width);
  }
}
