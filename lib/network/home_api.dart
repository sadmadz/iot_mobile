import 'package:iot/model/home.dart';

import 'base_api_provider.dart';

class HomeApi {

  Future<List<Home>> getHomes() async {
    String dataURL = "homes/";
    final response = await ApiProvider()
        .dio
        .get(dataURL)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((x) => Home.fromJson(x))
          .toList();
    } else {
      throw Exception();
    }
  }


  Future<bool> postHome(String name) async {
    String dataURL = "homes/";
    Map<String, String> param = {"name": name};

    final response = await ApiProvider()
        .dio
        .post(dataURL,data: param)
        .catchError((onError){
      print(onError);
    });
    print(response);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception();
    }
  }

  Future<bool> removeHome(String id) async {

    String dataURL = "home/$id";
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

}
