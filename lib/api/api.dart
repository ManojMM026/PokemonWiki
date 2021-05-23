import 'package:dio/dio.dart';
import 'package:mypokedex/util/app_constants.dart';

///API class responsible for calling http api.
class Api {
  Dio dio = Dio();

  Api() {
    dio.options.connectTimeout = AppConstants.connectionTimeOut;
    dio.options.receiveTimeout = AppConstants.responseTimeOut;
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  Future<Response> post(
      {String endPoint,
      Map<String, dynamic> data,
      Map<String, dynamic> headers}) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    if (headers != null) {
      dio.options.headers = headers;
    }
    try {
      Response response = await dio.post(endPoint, data: data);
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<Response> patch(
      {String endPoint,
      Map<String, dynamic> data,
      Map<String, dynamic> headers}) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    if (headers != null) {
      dio.options.headers = headers;
    }
    try {
      Response response = await dio.patch(endPoint, data: data);
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }

  Future<Response> get(
      {String endPoint, Map<String, int> queryParameters}) async {
    dio.options.baseUrl = AppConstants.baseUrl;
    try {
      Response response =
          await dio.get(endPoint, queryParameters: queryParameters);
      return Future.value(response);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
