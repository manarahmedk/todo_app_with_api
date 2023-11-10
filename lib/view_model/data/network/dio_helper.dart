import 'package:dio/dio.dart';
import 'package:todo_app/view_model/data/network/end_points.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Accept' : 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Response?> get({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
    String? token,
  }) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response = await dio?.get(
        endPoint,
        data: body,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> put({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
    String? token,
  }) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response = await dio?.put(
        endPoint,
        data: body,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> post({
    required String endPoint,
    Map<String, dynamic>? body,
    FormData? formData,
    Map<String, dynamic>? parameters,
    String? token,
  }) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response = await dio?.post(
        endPoint,
        data: body ?? formData,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> patch({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
    String? token,
  }) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response = await dio?.patch(
        endPoint,
        data: body,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response?> delete({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? parameters,
    String? token,
  }) async {
    try {
      dio?.options.headers = {
        "Authorization": "Bearer $token",
      };
      Response? response = await dio?.delete(
        endPoint,
        data: body,
        queryParameters: parameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
