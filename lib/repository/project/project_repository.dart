
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/project/project_model.dart';
import 'package:wabiz_app/model/project/reward_model.dart';
import 'package:wabiz_app/service/project/project_api.dart';
import 'package:wabiz_app/service/project/project_api_service.dart';
import 'package:wabiz_app/shared/model/response_model.dart';

part 'project_repository.g.dart';

class ProjectRepository {
  ProjectApiClient projectService;

  ProjectRepository(this.projectService);

  Future<ResponseModel?> createProject(ProjectItemModel body) async {
    final result = await projectService.createProject(body);
    return result;
  }

  Future<ResponseModel?> updateProjectOpenState(String id, ProjectItemModel body) async {
    final result = await projectService.updateProjectOpenState(id, body);
    return result;
  }

  Future<ResponseModel?> deleteProject(String id) async {
    final result = await projectService.deleteProject(id);
    return result;
  }

  Future<ResponseModel?> createdProjectReward(String id, RewardItemModel body) async {
    final result = await projectService.createProjectReward(id, body);
    return result;
  }

  Future<ProjectModel> getProjectByUserId(String userId) async {
    final result = await projectService.getProjectByUserId(userId);
    return result;
  }

  Future<ProjectModel> getProjectByProjectId(String id) async {
    final result = await projectService.getProjectByProjectId(id);
    return result;
  }
}

@riverpod
ProjectRepository projectRepository(Ref ref) {
  final service = ref.watch(projectApiServiceProvider);
  return ProjectRepository(service);
}