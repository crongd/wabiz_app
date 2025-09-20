import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/login/login_model.dart';
import 'package:wabiz_app/service/login/login_api.dart';
import 'package:wabiz_app/service/login/login_api_service.dart';
import 'package:wabiz_app/shared/model/response_model.dart';

part 'login_repository.g.dart';

class LoginRepository {
  LoginApiClient loginService;

  LoginRepository(this.loginService);

  Future<ResponseModel> signUp(LoginModel body) async {
    final result = await loginService.signup(body);
    return result;
  }

  Future<ResponseModel> checkEmail(LoginModel body) async {
    final result = await loginService.checkEmail(body);
    return result;
  }

  Future<ResponseModel?> signIn(LoginModel body) async {
    final result = await loginService.signIn(body);
    if (result.response.statusCode == 204) {
      return null;
    } else {
      return ResponseModel.fromJson(result.data);
    }
  }
}

@riverpod
LoginRepository loginRepository(Ref ref) {
  final service = ref.watch(loginApiClientProvider);
  return LoginRepository(service);
}