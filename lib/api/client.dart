import 'dart:io';

import 'package:app_firestore/config.dart';
import 'package:app_firestore/model/app_exxception.dart';
import 'package:dio/dio.dart';

class Request {
  // ignore: top_level_function_literal_block, prefer_function_declarations_over_variables
  static final client = () async {
    var dio = Dio(
      BaseOptions(
        followRedirects: true,
        headers: {"Accept": "application/json"},
        connectTimeout: 30000,
        receiveTimeout: 30000,
        baseUrl: AppConfig.gateway,
      ),
    );
    return dio;
  };
  static dynamic _returnResponse(Response? response) {
    print("======= API RESPONSE ====");
    if (response == null) {
      throw AppException(message: 'Tidak dapat terkoneksi dengan API');
    }
    print(response.data);
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = response.data;
        return responseJson;
      case 201:
        var responseJson = response.data;
        return responseJson;
      default:
        throw AppException(message: 'Terjadi Error');
    }
  }

  static dynamic _returnErr(DioError err) {
    print("=======API ERROR====");
    print(err);
    var response = err.response;
    if (response == null) {
      throw AppException(message: err.message);
    }
    print(err.response);
    print("===============RESPONSE DATA====================");
    print(err.response!.data);
    if (err.response!.data['error'] == null) {
      throw AppException(
          message: response.data['error']['message'] ?? 'Undefined Error 500');
    }
    return _returnResponse(err.response);
  }

  static Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameter}) async {
    var responseJson;
    try {
      Dio _client = await client();
      dynamic response =
          await _client.get(url, queryParameters: queryParameter);
      responseJson = _returnResponse(response);
    } on SocketException catch (err) {
      print("==========SOCKET EXCEPTION=========");
      print(err);
      throw AppException(message: 'No Internet connection');
    } on DioError catch (err) {
      print("==========DIO ERROR=========");
      print(err);
      responseJson = _returnResponse(err.response);
    }
    return responseJson;
  }

  static Future<dynamic> post(String url, {dynamic data}) async {
    var responseJson;
    Response response;
    try {
      Dio _client = await client();
      print("=============POSTING DATA=============");
      print(data.toString());
      response = await _client.post(url, data: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw AppException(message: 'No Internet connection');
    } on DioError catch (err) {
      responseJson = _returnErr(err);
    }
    return responseJson;
  }

  static Future<dynamic> put(String url, {dynamic data}) async {
    var responseJson;
    Response response;
    try {
      Dio _client = await client();
      print("=============POSTING DATA=============");
      print(data.toString());
      response = await _client.put(url, data: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw AppException(message: 'No Internet connection');
    } on DioError catch (err) {
      responseJson = _returnErr(err);
    }
    return responseJson;
  }

  static Future<dynamic> delete(String url, {dynamic data}) async {
    var responseJson;
    Response response;
    try {
      Dio _client = await client();
      print("=============POSTING DATA=============");
      print(data.toString());
      response = await _client.delete(url, data: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw AppException(message: 'No Internet connection');
    } on DioError catch (err) {
      responseJson = _returnErr(err);
    }
    return responseJson;
  }
}
