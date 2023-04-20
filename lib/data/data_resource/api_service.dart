import 'package:dio/dio.dart';
import '../../api_constants.dart';

class ApiService {
  final Dio _dio;

  ApiService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
          ),
        );

  Future<Response> getData(
    String path, {
    Map<String, dynamic>? queryParams,
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': 'ar',
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response;
    } on DioError catch (error) {
      throw _handleError(error);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> postData(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    String? token,
  }) {
    _dio.options.headers = {
      'lang': 'ar',
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          _dio.post(path, queryParameters: queryParams, data: body);
      return response;
    } on DioError catch (error) {
      throw _handleError(error);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> update(String path,
      {Map<String, dynamic>? queryParams, Map<String, dynamic>? body,  String? token}) {
    try {
      final response = _dio.put(path, queryParameters: queryParams, data: body);
      return response;
    } on DioError catch (error) {
      throw _handleError(error);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Exception _handleError(DioError error) {
    String errorMessage = '';
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        errorMessage = 'TimeOut';
        break;
      case DioErrorType.badResponse:
        errorMessage =
            'Bad Response ${error.response?.statusCode}: ${error.response?.statusMessage}';
        break;
      case DioErrorType.cancel:
        errorMessage = 'Cancel Erorr';
        break;
      default:
        print('Network Erorr !!!');
        break;
    }
    return Exception(errorMessage);
  }
}
