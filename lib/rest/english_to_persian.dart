
import 'package:flutter/material.dart';

class PersianEditTextController extends TextEditingController {
  PersianEditTextController() {
    this.addListener(() {
      this.updateValue(this.numberValue);
    });
  }

  void updateValue(String value) {
    String valueToUse = value;

    String masked = this._applyMask(valueToUse);

    if (masked != this.text) {
      this.text = masked;

      var cursorPosition = super.text.length;
      this.selection = new TextSelection.fromPosition(
          new TextPosition(offset: cursorPosition));
    }
  }

  String get numberValue {
    List<String> parts = this.text.split('').toList(growable: true);
    return parts.join();
  }


  String _applyMask(String value) {
    List<String> textRepresentation = value.toString()
        .replaceAll( "0","۰")
        .replaceAll( "1","۱")
        .replaceAll( "2","۲")
        .replaceAll( "3","۳")
        .replaceAll( "4","۴")
        .replaceAll( "5","۵")
        .replaceAll( "6","۶")
        .replaceAll( "7","۷")
        .replaceAll( "8","۸")
        .replaceAll( "9","۹")
        .split('')
        .reversed
        .toList(growable: true);
    return textRepresentation.reversed.join('');
  }
}



class EnglishToPersian {
  String number;

  String getNumber() {
    return number;
  }

  EnglishToPersian(String num) {


    this.number = (num)
        .replaceAll( "0","۰")
        .replaceAll( "1","۱")
        .replaceAll( "2","۲")
        .replaceAll( "3","۳")
        .replaceAll( "4","۴")
        .replaceAll( "5","۵")
        .replaceAll( "6","۶")
        .replaceAll( "7","۷")
        .replaceAll( "8","۸")
        .replaceAll( "9","۹");
  }
}

