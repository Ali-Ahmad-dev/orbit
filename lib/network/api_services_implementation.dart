import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/login_model.dart';
import '../constants/network/network_endpoints.dart';
import 'api_services.dart';

class ApiServicesImplementation extends ApiServices {
  Dio dio = Dio();

  @override
  Future basicAuth(String endpoint, data) async {
    final url = NetworkEndpoints.BASE_URL + endpoint;
    dynamic responseJson = {};
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('${data['username']}:${data['password']}'))}';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'authorization': basicAuth,
          },
        ),
        // Optional timeout setting
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print('Received: ${(received / total * 100).toStringAsFixed(0)}%');
          }
        },
      ).timeout(const Duration(seconds: 20));

      responseJson = response.data;
    } catch (ex) {
      print("Error in basicAuth: $ex");
      return null;
    }
    return responseJson;
  }

  @override
  Future postData(String endpoint, data) async {
    dynamic responseJson = {};
    final url = NetworkEndpoints.BASE_URL + endpoint;
    final preferencesController = Get.find<LoginModel>();
    var token = preferencesController.token!;

    try {
      final response = await dio
          .post(
            url,
            data: jsonEncode(data),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 60));

      print('postData | ${response.data}');
      responseJson = response.data;
      responseJson['statusCode'] = response.statusCode;
    } catch (e) {
      print('postData | $e');
    }
    return responseJson;
  }

  @override
  Future getData(String endpoint,
      {Map<String, String> addHeaders = const {}}) async {
    dynamic responseJson = {};
    final url = NetworkEndpoints.BASE_URL + endpoint;
    final preferencesController = Get.find<LoginModel>();
    var token = preferencesController.token!;

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        ...addHeaders,
      };

      final response = await dio
          .get(
            url,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 40));

      debugPrint(response.data.toString());
      responseJson = response.data;
      responseJson['statusCode'] = response.statusCode;
    } on SocketException {
      throw ('No Internet Connection');
    } catch (e) {
      print('getData | $e');
    }
    return responseJson;
  }

  @override
  Future getDataWithoutStatusCode(String endpoint,
      {Map<String, String> addHeaders = const {}}) async {
    dynamic responseJson = {};
    final url = NetworkEndpoints.BASE_URL + endpoint;
    final preferencesController = Get.find<LoginModel>();
    var token = preferencesController.token!;

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        ...addHeaders,
      };

      final response = await dio
          .get(
            url,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 40));

      debugPrint(response.data.toString());
      responseJson = response.data;
    } on SocketException {
      throw ('No Internet Connection');
    } catch (e) {
      print('getDataWithoutStatusCode | $e');
    }
    return responseJson;
  }

  @override
  Future postDataWithoutToken(String endpoint, data) async {
    dynamic responseJson = {};
    final url = NetworkEndpoints.BASE_URL + endpoint;

    try {
      final response = await dio
          .post(
            url,
            data: jsonEncode(data),
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
            ),
          )
          .timeout(const Duration(seconds: 40));

      print('postDataWithoutToken | ${response.data}');
      responseJson = response.data;
      responseJson['statusCode'] = response.statusCode;
    } catch (e) {
      Get.snackbar('Error', 'postDataWithoutToken | $e');
      print('postDataWithoutToken | $e');
    }
    return responseJson;
  }
}
