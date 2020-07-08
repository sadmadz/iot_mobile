import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiProvider {
  final String _endpoint = "https://lixil.herokuapp.com/api/v1/";
  Dio _dio = new Dio();

  ApiProvider() {
    _dio.options.contentType = "application/json";
    _dio.options.connectTimeout = 50000; //5s
    _dio.options.receiveTimeout = 30000;
//    _dio.options.headers["Authorization"] = "Bearer $_token";
    _dio.options.baseUrl = _endpoint;
  }
  Dio get dio => _dio;
}
