
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/service/project/project_api.dart';
import 'package:wabiz_app/shared/network_provider.dart';

part 'project_api_service.g.dart';

@riverpod
ProjectApiClient projectApiService(Ref ref) {
  final dio = ref.watch(dioProvider);
  var localhost = 'localhost';
  if (defaultTargetPlatform == TargetPlatform.android) {
    localhost = '10.0.2.2';
  }
  return ProjectApiClient(dio, baseUrl: 'http://$localhost:3000/api/v1');
}