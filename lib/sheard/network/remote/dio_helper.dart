import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> getDate({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(queryParameters: query, url);
  }

  static Future<Response> postDate({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? authorization,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': authorization,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
