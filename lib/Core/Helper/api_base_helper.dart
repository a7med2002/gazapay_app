import 'dart:convert';
import 'dart:io';

import 'package:gazapay/Core/Helper/app_exceptions.dart';
import 'package:gazapay/Core/Util/constants.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(String url, Map<String, String> header) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(baseUrl + url),
        headers: header,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url,
    Map<String, dynamic> body,
    Map<String, String> header,
  ) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(baseUrl + url),
        body: jsonEncode(body),
        headers: header,
      );

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> update(
    String url,
    Map<String, String> body,
    Map<String, String> header,
  ) async {
    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(baseUrl + url),
        body: body,
        headers: header,
      );
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> delete(String url, Map<String, String> header) async {
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(baseUrl + url),
        headers: header,
      );
      responseJson = _returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseBody;

      case 400:
        throw BadRequestException(responseBody['message'].toString());

      case 401:
      case 403:
        throw UnauthorisedException(responseBody['message'].toString());

      case 404:
        throw FetchDataException("Resource not found");

      case 409:
        throw ConflictException(responseBody['message'].toString());

      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
