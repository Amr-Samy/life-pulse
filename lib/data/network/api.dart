import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../presentation/resources/helpers/functions.dart';
import '../../presentation/resources/helpers/storage.dart';
import '../../presentation/resources/strings_manager.dart';

class Api {
  final dio = createDio();
  String _token = "";
  String _apiKey = "";
  String _languageCode = 'en';

  Api._internal();

  set languageCode(String value) {
    if (value.isNotEmpty) {
      _languageCode = value;
    }
  }
  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: "https://nabd.kirellos.com/api/",
      contentType: Headers.jsonContentType,
        validateStatus: (int? status) {
          return status != null;
        },
      // connectTimeout: const Duration(milliseconds: 30000),
      //30 secs
      // receiveTimeout: const Duration(milliseconds: 30000),
      //30 secs
      sendTimeout: const Duration(milliseconds: 30000),
      //20secs
        maxRedirects: 2));
    dio.interceptors.addAll({ErrorInterceptor(dio)});
    return dio;
  }

  String get token => _token;

  set token(String? value) {
    if (value != null && value.isNotEmpty) {
      _token = value;
    }
  }

  String get apiKey => _apiKey;

  set apiKey(String? value) {
    if (value != null && value.isNotEmpty) {
      _apiKey = value;
    }
  }

  clearKeyToken() {
    _token = "";
    _apiKey = "";
  }

  ///[GET] We will use this method inorder to process get requests
  Future<Response> get(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    debugPrint("GETTING API FROM : ${dio.options.baseUrl + path}");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    debugPrint("QUERY PARAMS=>$queryParameters");
    return await dio.get(dio.options.baseUrl + path,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        options: options,
        queryParameters: queryParameters);
  }

  ///[POST] We will use this method inorder to process post requests
  Future<Response> post(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    debugPrint("URL : ${dio.options.baseUrl + path}");
    debugPrint("Request body : $data");
    debugPrint("Request jsonEncode(data) : ${jsonEncode(data)}");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    return await dio.post(dio.options.baseUrl + path,
        data: jsonEncode(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }

  ///[POST with FormData] We will use this method to process post requests with files.
  Future<Response> postFormData(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        bool addRequestInterceptor = true,
      }) async {
    debugPrint("URL : ${dio.options.baseUrl + path}");
    debugPrint("Request body : $data");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    return await dio.post(dio.options.baseUrl + path,
        data: FormData.fromMap(data), // Use FormData here
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }


  ///[PUT] We will use this method inorder to process post requests
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    debugPrint("URL : ${dio.options.baseUrl + path}");
    debugPrint("Request body : $data");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    return await dio.put(dio.options.baseUrl + path,
        data: FormData.fromMap(data),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress);
  }

  /// [PATCH] We will use this method to process patch requests
  Future<Response> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        bool addRequestInterceptor = true,
      }) async {
    debugPrint("URL : ${dio.options.baseUrl + path}");
    debugPrint("Request body : $data");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    return await dio.patch(
      dio.options.baseUrl + path,
      data: FormData.fromMap(data),
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }


  ///[DELETE] We will use this method inorder to process delete requests
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool addRequestInterceptor = true,
  }) async {
    debugPrint("DELETING API FROM : ${dio.options.baseUrl + path}");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    debugPrint("QUERY PARAMS=>$queryParameters");
    return await dio.delete(dio.options.baseUrl + path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
  }

}

class ErrorInterceptor extends Interceptor {
  final Dio dio;

  ErrorInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        debugPrint("STATUS CODE : ${err.response?.statusCode}");
        debugPrint("${err.response?.data}");
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            //forceLogout();
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 422:
            {
              showErrorSnackBar(message: err.response?.data["error"]);
            }
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
      // TODO: Handle this case.
        break;
      case DioExceptionType.unknown:
        debugPrint(err.message);
        throw UnKnownException(err.requestOptions);
      case DioExceptionType.badCertificate:
        debugPrint(err.message);
        throw  CertificateException(err.message.toString());
      case DioExceptionType.connectionError:
        debugPrint(err.message);
        throw NoInternetConnectionException(err.requestOptions);

    }
    return handler.next(err);
  }
}

class RequestInterceptor extends Interceptor {
  final Dio dio;
  final String apiKey;
  final String token;

  RequestInterceptor(this.dio, {required this.token, required this.apiKey});
  final secureStorage = TokenStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final api = Api(); // Get the current Api instance

    options.headers = {
      'apiKey': apiKey,
      'Authorization': "Bearer ${secureStorage.getToken()}" ??token,
      "content-type": "application/json",
      "Accept-Language": api._languageCode,
    };
    return handler.next(options);
  }
}

class ConnectionTimeOutException extends DioException {
  ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.connectionTimeOut.tr;
  }
}

class SendTimeOutException extends DioException {
  SendTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.sendTimeOut.tr;
  }
}

class ReceiveTimeOutException extends DioException {
  ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.receiveTimeOut.tr;
  }
}

//**********-----STATUS CODE ERROR HANDLERS--------**********

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.invalidRequest.tr;
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.internalError.tr;
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.conflictError.tr;
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.unauthorizedAccess.tr;
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.notFoundError.tr;
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.noInternetError.tr;
  }
}

class UnKnownException extends DioException {
  UnKnownException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return AppStrings.unKnownError.tr;
  }

}
