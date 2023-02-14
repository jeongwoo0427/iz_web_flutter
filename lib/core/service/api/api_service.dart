import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../model/error/http_failure.dart';


///Echo API 규격에 맞게 개발된 Service 객체
class APIService {
  final String baseUrl;

  APIService({
    this.baseUrl = 'http://211.43.14.38:33/api',
  });

  Future<Response> request(String pathString,
      {String method = 'GET',
        String contentType = 'application/json',
        Map<String, String> headers = const {},
        dynamic data = const {},
        Iterable<Interceptor> interceptors = const [],
        timeoutSec = 5}) async {
    Dio dio = Dio(BaseOptions(baseUrl: this.baseUrl, receiveTimeout: timeoutSec * 1000, connectTimeout: timeoutSec * 1000));

    dio.options.headers['content-Type'] = contentType;
    dio.options.headers.addAll(headers);
    dio.options.method = method;
    dio.interceptors.addAll(interceptors);

    try {
      final response = await dio.request(pathString, data: data);

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 203 || response.statusCode == 204) {
        // print(data);
        return response;
      } else {
        throw '오류가 발생했습니다 (${response.statusCode.toString()})';
      }
    } on DioError catch (err) {
      log('API_Service error)' + err.toString());

      if (err.type == DioErrorType.response && err.response != null) {
        if (err.response!.statusCode == 400) {
          throw HttpFailure(code: 400, message: '잘못된 요청입니다. [400]');
        } else if (err.response!.statusCode == 404) {
          log('API_service_requestedUrl : ${err.requestOptions.uri}');
          throw HttpFailure(code: 404, message: '잘못된 URL 요청입니다.');
        } else if (err.response!.statusCode == 408) {
          throw HttpFailure(code: 408, message: '연결이 불안정합니다. 잠시후 다시 시도해주세요.');
        } else if (err.response!.statusCode == 401) {
          throw HttpFailure(code: 401, message: err.response?.data['message'] ?? '인증오류가 발생했습니다.');
        } else if (err.response!.statusCode == 419) {
          throw HttpFailure(code: 419, message: '로그인 유효기간이 만료되었습니다. 다시 로그인해주세요.');
        } else if (err.response!.statusCode == 500) {
          log('API_Service error)' + (err.response?.data).toString());
          throw HttpFailure(code: 500, message: '서버에서 오류가 발생했습니다.');
        } else {
          throw HttpFailure(code: err.response!.statusCode ?? 500, message: '오류가 발생했습니다 [${err.response!.statusCode ?? 500}]');
        }
      }

      if (err.type == DioErrorType.connectTimeout || err == DioErrorType.receiveTimeout) {
        throw HttpFailure(code: 408, message: '서버 연결이 원활하지 않습니다');
      }

      if (err.type == DioErrorType.other) {
        if (err.error is SocketException) {
          throw HttpFailure(code: 503, message: '인터넷 접속이 없습니다.');
        }
      }

      throw '오류 : [${err.error}]';
    } catch (ex) {
      log('API_Service error) unknown error occurred');
      throw ex;
    }
  }
}