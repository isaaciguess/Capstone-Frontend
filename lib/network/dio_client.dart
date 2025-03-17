import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  final Dio dio;
  final CookieJar cookieJar = CookieJar();

  DioClient._internal()
      : dio = Dio(BaseOptions(
          baseUrl: "http://localhost:3000/api",
          contentType: "application/json",
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),
        )) {
    dio.interceptors.add(CookieManager(cookieJar)); // Automatically handle cookies
  }
}

final dioClient = DioClient();