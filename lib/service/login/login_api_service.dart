import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/service/login/login_api.dart';
import 'package:wabiz_app/shared/network_provider.dart';

part 'login_api_service.g.dart';

@Riverpod(keepAlive: true)
LoginApiClient loginApiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  var localhost = 'localhost';

  if(defaultTargetPlatform == TargetPlatform.android) {
    localhost = '10.0.2.2';
  }

  return LoginApiClient(dio, baseUrl: 'http://$localhost:3000/api/v1');
}