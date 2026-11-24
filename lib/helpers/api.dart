import 'package:http/http.dart' as http;
import 'package:flutter_application_1/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  Future<dynamic> _headers() async {
    final token = await UserInfo().getToken();
    final Map<String, String> headers = {'Accept': 'application/json'};

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<dynamic> post(dynamic url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: await _headers(),
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(dynamic url, dynamic data) async {
    dynamic responseJson;
    try {
      final headers = await _headers();
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
      final response = await http.put(
        Uri.parse(url),
        body: data,
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: await _headers(),
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: await _headers(),
      );
      responseJson = _returnResponse(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}