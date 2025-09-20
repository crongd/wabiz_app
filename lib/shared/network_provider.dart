import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_provider.g.dart';

@riverpod
Dio dio(ref) {
  var localhost = 'localhost';

  if(defaultTargetPlatform == TargetPlatform.android) {
    localhost = '10.0.2.2';
  }

  final options = BaseOptions(
    baseUrl: 'http://192.168.219.117:3000/api/v1',
    responseType: ResponseType.json,
    headers: {
      'Content-Type': 'application/json',
    },
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  );
  return Dio(options);
}