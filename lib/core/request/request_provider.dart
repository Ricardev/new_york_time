import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_york_time_api/core/error/exceptions.dart';

import '../enum/enums.dart';
import 'i_request_provider.dart';
import 'package:dio/dio.dart';

class RequestProvider implements IRequestProvider, InterceptorsWrapper {
  final Dio dio = Dio();
  String? dataName = '';
  static const String apiKey = "Zdxm0seEABDG2gwoWFdeEYYEZlTWLhR0";

  RequestProvider() {
    dio.options.connectTimeout = Duration(milliseconds: Timeout.connectTimeout);
    dio.options.receiveTimeout = Duration(milliseconds: Timeout.receiveTimeout);
    dio.interceptors.add(this);
  }

  @override
  void setDataName(String name) => dataName = name;

  @override
  Future<T> deleteAsync<T>(String url, T objeto,
      T Function(Map<String, dynamic> json) fromJson) async {
    var response = await dio.delete(url);
    if (response.data != null) {
      return fromJson(response.data) ?? response.data as T;
    } else {
      return response.data;
    }
  }

  @override
  Future<T> getAsync<T>(String url,
      {Map<String, dynamic> requestParameters = const {
        "api-key": apiKey
      }}) async {
    dynamic response;
    try {
      response = await dio.get(url, queryParameters: requestParameters);
    } on DioError catch (error) {
      response = error.response;
      throw ServerException();
    }
    if (response.data != null) {
      return response.data ?? response.data as T;
    } else {
      return response.data;
    }
  }

  @override
  Future<T> postAsync<T>(
    String url,
  ) async {
    dynamic response;
    try {
      response = await dio.post(url);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
    if (response != null) {
      return response.data;
    } else {
      return response.data;
    }
  }

  @override
  Future<T> putAsync<T>(String url, T objeto,
      T Function(Map<String, dynamic> json) fromJson) async {
    var str = json.encode(objeto);
    dynamic response;
    try {
      response = await dio.put(url, data: str);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
    if (response.data != null) {
      return fromJson(response.data) ?? response.data as T;
    } else {
      return response;
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(err.message);
    debugPrint(err.response.toString());
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(response.realUri.toString());
    debugPrint('----------------------');
    debugPrint(response.statusCode.toString());
    debugPrint('----------------------');
    debugPrint(response.data.toString());
    handler.next(response);
  }

  @override
  void setHeaders(Map<String, dynamic> headers) => dio.options.headers;
}
