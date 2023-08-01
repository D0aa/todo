import 'package:dio/dio.dart';
import 'package:to_do_app/veiw_model/data/network/end_points.dart';




class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
          baseUrl: EndPoints.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    if (token != null) {
      dio!.options.headers = {'Authorization': 'Token token="$token"'};
    }
    try {
      final Response response = await dio!.get(
        endPoint,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    if (token != null) {
      dio!.options.headers = {'Authorization': 'Token token="$token"'};
    }
    try {
      final Response response = await dio!.post(
        endPoint,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> putData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    if (token != null) {
      dio!.options.headers = {'Authorization': 'Token token="$token"'};
    }
    try {
      final Response response = await dio!.put(
        endPoint,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> patchData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    if (token != null) {
      dio!.options.headers = {'Authorization': 'Token token="$token"'};
    }
    try {
      final Response response = await dio!.patch(
        endPoint,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    if (token != null) {
      dio!.options.headers = {'Authorization': 'Token token="$token"'};
    }
    try {
      final Response response = await dio!.delete(
        endPoint,
        queryParameters: queryParameters,
        data: body,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

}
