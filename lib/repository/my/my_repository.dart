
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/project/project_model.dart';
import 'package:wabiz_app/service/project/project_api.dart';
import 'package:wabiz_app/service/project/project_api_service.dart';
import 'package:wabiz_app/shared/model/response_model.dart';

part 'my_repository.g.dart';

@riverpod
MyRepositoryImpl myRepository(Ref ref) {
  return MyRepositoryImpl(ref.watch(projectApiServiceProvider));
}

abstract class MyRepository {

  Future getProjectByUserId(String userId);

  Future updateProjectOpenState(String id, ProjectItemModel body);

  Future deleteProject(String id);

}

class MyRepositoryImpl implements MyRepository {

  ProjectApiClient projectApiClient;

  MyRepositoryImpl(this.projectApiClient);

  @override
  Future<ResponseModel> deleteProject(String id) async {
    final result = await projectApiClient.deleteProject(id);
    return result;
  }

  @override
  Future<ProjectModel> getProjectByUserId(String userId) async {
    final result = await projectApiClient.getProjectByUserId(userId);
    return result;
  }

  @override
  Future<ResponseModel> updateProjectOpenState(String id, ProjectItemModel body) async {
    final result = await projectApiClient.updateProjectOpenState(id, body);
    return result;
  }

}