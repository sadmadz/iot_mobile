import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iot/global.dart';
import 'package:iot/model/thing.dart';
import 'package:iot/model/thing_type.dart';
import 'package:iot/network/type_api.dart';
import 'package:iot/rest/custom_loading.dart';
import 'package:iot/rest/date_time_modifier.dart';

import 'customfonts/font_awesome_flutter.dart';
import 'customfonts/icon_data.dart';
import 'model/home.dart';
import 'network/home_api.dart';
import 'network/thing_api.dart';
import 'rest/lottieIndicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String homeName = null;
  StateSetter _stateSetter;
  StateSetter _stateSetter2;
  StateSetter _stateSetter3;
  bool addingHome = false;
  bool updatingThing = false;
  bool addingThing = false;
  bool removingThing = false;
  bool loadingThings = false;

  postNewHome(String name) async {
    HomeApi homeApi = new HomeApi();
    homeApi.postHome(name).then((_response) {
      if (_response != null && _response) {
        getHomes();
      } else {}
    }).catchError((onError) {
      print("_response");
      print(onError);
      final snackBar = SnackBar(content: Text('خطایی رخ داد!'));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  getHomes() async {
    HomeApi homeApi = new HomeApi();
    homeApi.getHomes().then((_response) {
      if (_response != null) {
        Global.homes.clear();
        Global.homes.addAll(_response);
        if (addingHome) {
          addingHome = false;
          Navigator.pop(context);
        }
        setState(() {});
      } else {
        getHomes();
      }
    }).catchError((onError) {
      print("_response");
      print(onError);
      getHomes();
    });
  }

  getThings(String id) async {
    setState(() {
      loadingThings = true;
    });
    ThingApi thingApi = new ThingApi();
    thingApi.getThings(id).then((_response) {
      if (_response != null) {
        Global.things.clear();
        Global.things.addAll(_response);
        setState(() {
          loadingThings = false;
        });
      } else {
        getThings(id);
      }
    }).catchError((onError) {
      print("_response");
      print(onError);
      getThings(id);
    });
  }

  postThing(String homeId, String name, String row, String column,
      String type) async {
    ThingApi thingApi = new ThingApi();
    thingApi.postThing(homeId, name, row, column, type).then((_response) {
      if (_response != null && _response) {
        addingThing = false;
        Navigator.pop(context);
        getThings(homeId);
      } else {}
    }).catchError((onError) {
      print("_response");
      print(onError);
    });
  }

  removeThing(String thingId) async {
    ThingApi thingApi = new ThingApi();
    thingApi.removeThing(thingId).then((_response) {
      if (_response != null && _response) {
        _stateSetter3(() {
          removingThing = false;
        });
        Navigator.pop(context);
        getThings(Global.homes
            .firstWhere((element) =>
        element.name == homeName).id.toString());
      } else {}
    }).catchError((onError) {
      print("_response");
      print(onError);
    });
  }

  removeHome(String id) async {
    HomeApi homeApi = new HomeApi();
    homeApi.removeHome(id).then((_response) {
      if (_response != null && _response) {
        Navigator.pop(context);
        setState(() {
          homeName = null;
          Global.things.clear();
        });
        getHomes();
      } else {
        Navigator.pop(context);
      }
    }).catchError((onError) {
      print("_response");
      print(onError);
      Navigator.pop(context);
    });
  }

  updateThing(Thing thing) async {
    ThingApi thingApi = new ThingApi();
    thingApi
        .updateThing(thing.id.toString(), thing.status, thing.name, int.parse(thing.thingRow),
            int.parse(thing.thingColumn), thing.type.id)
        .then((_response) {
      if (_response != null && _response) {
        _stateSetter3(() {
          updatingThing = false;
        });
        Navigator.pop(context);
        getThings(Global.homes
            .firstWhere((element) =>
        element.name == homeName).id.toString());
      } else {}
    }).catchError((onError) {
      print("_response");
      print(onError);
    });
  }

  addHomeDialog() {
    var nameController = new TextEditingController();

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            _stateSetter = setModalState;
            return Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text("اطلاعات خانه جدید",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "VazirMedium",
                                    fontSize: 20.0,
                                    color: Colors.blueGrey[800])),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 12.0, left: 6.0, right: 12.0),
                                    child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[50],
                                          filled: true,
                                          contentPadding: EdgeInsets.all(12),
                                          counterText: "",
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500],
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "نام خانه",
                                          labelStyle: TextStyle(
                                              fontFamily: "VazirMedium",
                                              fontSize: 13.0,
                                              color: Colors.grey[500]),
                                        ),
                                        style: TextStyle(
                                            fontFamily: "VazirMediumFD",
                                            fontSize: 13.0,
                                            color: Colors.blueGrey[800]),
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {})),
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 12,
                              highlightElevation: 1,
                              disabledElevation: 2,
                              color: Colors.white,
                              hoverColor: Colors.white,
                              highlightColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    addingHome
                                        ? LottieIndicator(
                                            "assets/animate/loading.json",
                                            height: 30,
                                            width: 30)
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4, left: 8),
                                            child: Icon(
                                              FontAwesomeIcons.checkRegular,
                                              size: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                    Text("تایید",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 13.0,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (nameController.text != "") {
                                  if ((Global.homes.singleWhere(
                                          (it) =>
                                              it.name == nameController.text,
                                          orElse: () => null)) ==
                                      null) {
                                    if (!addingHome) {
                                      FocusScope.of(context).unfocus();
                                      postNewHome(nameController.text);
                                    }
                                    _stateSetter(() {
                                      addingHome = true;
                                    });
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(
                                          'نام خانه نمیتواند تکراری باشد',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "VazirMedium",
                                              fontSize: 13.0,
                                              color: Colors.white)),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.blueGrey[800],
                                      behavior: SnackBarBehavior.floating,
                                    );
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text('فیلد نام را وارد نمایید.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 13.0,
                                            color: Colors.white)),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.blueGrey[800],
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ));
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: anim1.drive(tween),
          child: child,
        );
      },
    );
  }

  addThingDialog(String row, String column) {
    var nameController = new TextEditingController();
    String type = null;

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            _stateSetter2 = setModalState;
            return Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text("اطلاعات شئ جدید",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "VazirMedium",
                                    fontSize: 20.0,
                                    color: Colors.blueGrey[800])),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 12.0, left: 6.0, right: 12.0),
                                    child: TextField(
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey[50],
                                          filled: true,
                                          contentPadding: EdgeInsets.all(12),
                                          counterText: "",
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500],
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 1.2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: "نام شئ",
                                          labelStyle: TextStyle(
                                              fontFamily: "VazirMedium",
                                              fontSize: 13.0,
                                              color: Colors.grey[500]),
                                        ),
                                        style: TextStyle(
                                            fontFamily: "VazirMediumFD",
                                            fontSize: 13.0,
                                            color: Colors.blueGrey[800]),
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        onChanged: (value) {})),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1.0,
                                          color: Colors.blueGrey[600]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      height: 35,
                                      child: DropdownButton<String>(
                                        elevation: 8,
                                        onChanged: (value) {
                                          _stateSetter2(() {
                                            type = value;
                                          });
                                        },
                                        icon: Container(
                                          child: Icon(
                                            FontAwesomeIcons.caretDown,
                                            size: 24,
                                            color: Colors.blueGrey[800],
                                          ),
                                        ),
                                        iconEnabledColor: Colors.blueGrey[800],
                                        value: type,
                                        style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.blueGrey[800]),
                                        hint: Text("انتخاب نوع",
                                            style: new TextStyle(
                                                fontFamily: 'VazirBold',
                                                color: Colors.blueGrey[800])),
                                        items:
                                            Global.types.map((ThingType item) {
                                          return new DropdownMenuItem<String>(
                                            value: item.name,
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(item.name,
                                                      style: new TextStyle(
                                                        color: Colors
                                                            .blueGrey[800],
                                                        fontFamily:
                                                            'VazirMedium',
                                                      )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: Icon(
                                                      IconDataRegular(
                                                          int.parse(item.code)),
                                                      size: 20,
                                                      color: Colors.grey[800],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 12,
                              highlightElevation: 1,
                              disabledElevation: 2,
                              color: Colors.white,
                              hoverColor: Colors.white,
                              highlightColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    addingThing
                                        ? LottieIndicator(
                                            "assets/animate/loading.json",
                                            height: 30,
                                            width: 30)
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4, left: 8),
                                            child: Icon(
                                              FontAwesomeIcons.checkRegular,
                                              size: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                    Text("تایید",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 13.0,
                                            color: Colors.white))
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (nameController.text == "") {
                                  final snackBar = SnackBar(
                                    content: Text('فیلد نام را وارد نمایید.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 13.0,
                                            color: Colors.white)),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.blueGrey[800],
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (type == null) {
                                  final snackBar = SnackBar(
                                    content: Text('نوع شئ را مشخص نمایید',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 13.0,
                                            color: Colors.white)),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.blueGrey[800],
                                    behavior: SnackBarBehavior.floating,
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  if (!addingThing) {
                                    FocusScope.of(context).unfocus();
                                    var homeId = Global.homes
                                        .firstWhere((element) =>
                                            element.name == homeName)
                                        .id
                                        .toString();
                                    var tempType = Global.types
                                        .firstWhere(
                                            (element) => element.name == type)
                                        .id
                                        .toString();
                                    postThing(homeId, nameController.text, row,
                                        column, tempType);
                                  }
                                  _stateSetter2(() {
                                    addingThing = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )),
                ));
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: anim1.drive(tween),
          child: child,
        );
      },
    );
  }

  viewThingDialog(Thing thing) {
    bool on = thing.status == "0" ? false : true;

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            _stateSetter3 = setModalState;
            return Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text("اطلاعات شی",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "VazirMedium",
                                    fontSize: 20.0,
                                    color: Colors.blueGrey[800])),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text("نام شی:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "VazirMedium",
                                        fontSize: 12.0,
                                        color: Colors.blueGrey[800])),
                              ),
                              Flexible(
                                  child: Text(thing.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "VazirMedium",
                                          fontSize: 12.0,
                                          color: Colors.blueGrey[800]))),
                            ],
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                  child: Text("وضعیت: ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "VazirMedium",
                                          fontSize: 12.0,
                                          color: Colors.blueGrey[800]))),
                              Flexible(
                                child: Text(
                                    thing.status == "1" ? "روشن" : "خاموش",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "VazirMedium",
                                        fontSize: 12.0,
                                        color: Colors.blueGrey[800])),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text("آخرین تغییر وضعیت: ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "VazirMedium",
                                        fontSize: 12.0,
                                        color: Colors.blueGrey[800])),
                              ),
                              Flexible(
                                  child: Text(
                                      DateTimeModifier(thing.updatedAt)
                                          .getFarsiDateTime(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "VazirMedium",
                                          fontSize: 12.0,
                                          color: Colors.blueGrey[800]))),
                            ],
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 0.5,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 4, right: 4),
                              child: Theme(
                                data: ThemeData(),
                                child: ShaderMask(
                                  child: CupertinoSwitch(
                                    activeColor: Colors.green[100],
                                    value: on,
                                    onChanged: (v) => _stateSetter3(() {
                                      on = v;
                                      if (on) {
                                        thing.status = "1";
                                      } else {
                                        thing.status = "0";
                                      }
                                    }),
                                  ),
                                  shaderCallback: (r) {
                                    return LinearGradient(
                                      colors: on
                                          ? [
                                              Colors.green[200],
                                              Colors.green[200]
                                            ]
                                          : [
                                              Colors.grey[500],
                                              Colors.grey[500]
                                            ],
                                    ).createShader(r);
                                  },
                                ),
                              )),
                          Container(
                            height: 40,
                            margin: EdgeInsets.only(bottom: 14),
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 12,
                              highlightElevation: 1,
                              disabledElevation: 2,
                              color: Colors.white,
                              hoverColor: Colors.white,
                              highlightColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.green[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    updatingThing
                                        ? LottieIndicator(
                                            "assets/animate/loading.json",
                                            height: 30,
                                            width: 30)
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4, left: 8),
                                            child: Icon(
                                              FontAwesomeIcons.checkRegular,
                                              size: 20,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                    Text("اعمال تغییرات",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 12.0,
                                            color: Colors.blueGrey[800]))
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (!updatingThing) {
                                  updateThing(thing);
                                }
                                _stateSetter3(() {
                                  updatingThing = true;
                                });
                              },
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              elevation: 12,
                              highlightElevation: 1,
                              disabledElevation: 2,
                              color: Colors.white,
                              hoverColor: Colors.white,
                              highlightColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    removingThing
                                        ? LottieIndicator(
                                            "assets/animate/loading.json",
                                            height: 30,
                                            width: 30)
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 4, left: 8),
                                            child: Icon(
                                              FontAwesomeIcons.trashAlt,
                                              size: 20,
                                              color: Colors.blueGrey[800],
                                            ),
                                          ),
                                    Text("حذف شئ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "VazirMedium",
                                            fontSize: 12.0,
                                            color: Colors.blueGrey[800]))
                                  ],
                                ),
                              ),
                              onPressed: () {
                                if (!removingThing) {
                                  removeThing(thing.id.toString());
                                }
                                _stateSetter3(() {
                                  removingThing = true;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                ));
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeOutCirc;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: anim1.drive(tween),
          child: child,
        );
      },
    );
  }

  gridItem(int index) {
    bool isEmpty = true;
    Thing sth;
    for (int i = 0; i < Global.things.length; i++) {
      int temp = int.parse(Global.things[i].thingColumn) +
          int.parse(Global.things[i].thingRow) * 10;
      if (temp == index) {
        isEmpty = false;
        sth = Global.things[i];
        break;
      }
    }
    var bColor = Colors.grey[300];
    if (!isEmpty) {
      if (sth.status == "1") {
        bColor = Colors.green[200];
      } else {
        bColor = Colors.amber[200];
      }
    }
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        color: bColor,
        child: !isEmpty
            ? Icon(
                IconDataRegular(int.parse(sth.type.code)),
                size: 20,
                color: Colors.grey[800],
              )
            : Container(),
      ),
      onTap: () {
        if (isEmpty) {
          addThingDialog((index ~/ 10).toString(), (index % 10).toString());
        } else {
          viewThingDialog(sth);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("اینترنت اشیاء"),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0, color: Colors.blueGrey[600]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  height: 35,
                                  child: DropdownButton<String>(
                                    elevation: 8,
                                    onChanged: (value) {
                                      getThings(Global.homes
                                          .firstWhere((element) =>
                                              element.name == value)
                                          .id
                                          .toString());
                                      setState(() {
                                        homeName = value;
                                      });
                                    },
                                    icon: Container(
                                      child: Icon(
                                        FontAwesomeIcons.caretDown,
                                        size: 24,
                                        color: Colors.blueGrey[800],
                                      ),
                                    ),
                                    iconEnabledColor: Colors.blueGrey[800],
                                    value: homeName,
                                    style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blueGrey[800]),
                                    hint: Text("انتخاب خانه",
                                        style: new TextStyle(
                                            fontFamily: 'VazirBold',
                                            color: Colors.blueGrey[800])),
                                    items: Global.homes.map((Home item) {
                                      return new DropdownMenuItem<String>(
                                        value: item.name,
                                        child: Container(
                                          child: Text(item.name,
                                              style: new TextStyle(
                                                color: Colors.blueGrey[800],
                                                fontFamily: 'VazirMedium',
                                              )),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.only(left: 6),
                              child: RaisedButton(
                                elevation: 12,
                                highlightElevation: 1,
                                disabledElevation: 2,
                                color: Colors.white,
                                hoverColor: Colors.white,
                                highlightColor: Colors.white,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 4, left: 8),
                                        child: Icon(
                                          FontAwesomeIcons.plus,
                                          size: 20,
                                          color: Colors.green[400],
                                        ),
                                      ),
                                      Text("افزودن خانه",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "VazirLight",
                                              fontSize: 11.0,
                                              color: Colors.blueGrey[800]))
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  addHomeDialog();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.only(right: 6),
                              child: RaisedButton(
                                elevation: 12,
                                highlightElevation: 1,
                                disabledElevation: 2,
                                color: Colors.white,
                                hoverColor: Colors.white,
                                highlightColor: Colors.white,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 4, left: 8),
                                        child: Icon(
                                          FontAwesomeIcons.trashAlt,
                                          size: 20,
                                          color: Colors.blueGrey[800],
                                        ),
                                      ),
                                      Text("حذف خانه",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "VazirLight",
                                              fontSize: 11.0,
                                              color: Colors.blueGrey[800]))
                                    ],
                                  ),
                                ),
                                onPressed: homeName == null
                                    ? null
                                    : () {
                                        showLoading(context, "در حال حذف خانه");
                                        removeHome(Global.homes
                                            .firstWhere((element) =>
                                                element.name == homeName)
                                            .id
                                            .toString());
                                      },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              loadingThings
                  ? Container(
                      height: MediaQuery.of(context).size.width - 20,
                      alignment: Alignment.center,
                      child: LottieIndicator("assets/animate/loading.json",
                          height: 50, width: 50),
                    )
                  : homeName != null
                      ? Container(
                          height: MediaQuery.of(context).size.width - 20,
                          width: MediaQuery.of(context).size.width - 20,
                          color: Colors.grey[200],
                          child: GridView.count(
                            physics: ClampingScrollPhysics(),
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            crossAxisCount: 10,
                            // Generate 100 widgets that display their index in the List.
                            children: List.generate(100, (index) {
                              return gridItem(index);
                            }),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Text("ابتدا خانه ی مورد نظر را انتخاب نمایید.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "VazirLight",
                                  fontSize: 11.0,
                                  color: Colors.blueGrey[800])),
                        )
            ],
          )),
    );
  }
}
