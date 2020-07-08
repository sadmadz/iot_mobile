import 'dart:convert';

import 'package:iot/model/data.dart';
import 'package:iot/model/thing_type.dart';

import 'base_api_provider.dart';

class TypeApi {
  Future<List<ThingType>> getTypes() async {
    String dataURL = "types/";
    final response = await ApiProvider()
        .dio
        .get(dataURL)
        .catchError((onError){
          print(onError);
    });
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => ThingType.fromJson(x))
          .toList();
    } else {
      throw Exception();
    }
  }
}
