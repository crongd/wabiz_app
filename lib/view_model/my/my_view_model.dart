import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/login/login_model.dart';
import 'package:wabiz_app/repository/my/my_repository.dart';
import 'package:wabiz_app/view_model/login/login_view_model.dart';

part 'my_view_model.g.dart';
part 'my_view_model.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  factory MyPageState({
    bool? loginState,
    LoginModel? loginModel,
  }) = _MyPageState;
}


@riverpod
class MyPageViewModel extends _$MyPageViewModel {
  @override
  MyPageState build() {
    final status = ref.watch(loginViewModelProvider);
    return MyPageState(
      loginState: status.isLogin,
      loginModel: LoginModel(
        email: status.email,
        username: status.username,
        id: status.userid,
      )
    );
  }

  fetchUserProjects() {

  }

  updateProject(String id) async {
    await ref.watch(myRepositoryProvider).updateProjectOpenState(id);
  }

  deleteProject(String id) async {
    await ref.read(myRepositoryProvider).deleteProject(id);
  }
}