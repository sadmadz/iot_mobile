import 'package:iot/model/home.dart';
import 'package:iot/model/thing.dart';

import 'base_api_provider.dart';

class ThingApi {

  Future<List<Thing>> getThings(String id) async {
    String dataURL = "things/$id";
    final response = await ApiProvider()
        .dio
        .get(dataURL)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => Thing.fromJson(x))
          .toList();
    } else {
      throw Exception();
    }
  }

  Future<bool> postThing(String homeId,String name,String row,String column,String type) async {
    Map<String, String> param = {
      "name": name,
      "status": "0",
      "thing_row": row,
      "thing_column": column,
      "type":type.toString()
    };

    String dataURL = "things/$homeId";
    final response = await ApiProvider()
        .dio
        .post(dataURL,data: param)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 201) {
      print("baby 200");
      return true;
    } else {
      print("baby exception");
      throw Exception();
    }
  }

  Future<bool> removeThing(String thingId) async {

    String dataURL = "thing/$thingId";
    final response = await ApiProvider()
        .dio
        .delete(dataURL)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }

  Future<bool> updateThing(String thingId,String status,String name,int row,int column,int type) async {
  Map<String, dynamic> param = {
    "name": name,
    "status": status,
    "thing_row": row,
    "thing_column": column,
    "type":type.toString()
  };
  print(param);

  String dataURL = "thing/$thingId";
    final response = await ApiProvider()
        .dio
        .put(dataURL,data: param)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception();
    }
  }
}
