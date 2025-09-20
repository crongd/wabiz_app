import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/category/category_model.dart';
import 'package:wabiz_app/repository/category/category_repository.dart';
import 'package:wabiz_app/shared/model/project_type.dart';

part 'category_view_model.g.dart';
part 'category_view_model.freezed.dart';

enum EnumCategoryProjectType {
  recommend('추천순'),
  lowFunded('낮은 펀딩금액순'),
  highFunded('높은 펀딩금액순');

  final String value;

  const EnumCategoryProjectType(this.value);
}

@freezed
class CategoryScreenState with _$CategoryScreenState {
  factory CategoryScreenState({
    ProjectType? selectedType,
    @Default(EnumCategoryProjectType.recommend) EnumCategoryProjectType? projectFilter,
    @Default([]) List<CategoryItemModel> projects,
    @Default(AsyncValue.loading()) AsyncValue<List<CategoryItemModel>> projectState,
  }) = _CategoryScreenState;
}

@riverpod
class CategoryViewModel extends _$CategoryViewModel {

  @override
  CategoryScreenState build() {
    return CategoryScreenState(
      selectedType: ProjectType(id: 0, type: '전체'),
      projectFilter: EnumCategoryProjectType.recommend,
      projects: []
    );
  }

  updateType(ProjectType type) {
    state = state.copyWith(
      selectedType: type,
      projectFilter: EnumCategoryProjectType.recommend,
    );
  }

  updateProjectFilter(EnumCategoryProjectType filter) {
    state = state.copyWith(
      projectState: AsyncValue.loading(),
      projectFilter: filter,
    );

    final _projects = [...state.projects];

    if (filter == EnumCategoryProjectType.lowFunded) {
      _projects.sort((a, b) {
        if ((a.totalFunded ?? 0) > (b.totalFunded ?? 0)) {
          return 1;
        } else {
          return -1;
        }
      });
    } else if (filter == EnumCategoryProjectType.highFunded) {
      _projects.sort((a, b) {
        if ((a.totalFunded ?? 0) > (b.totalFunded ?? 0)) {
          return -1;
        } else {
          return 1;
        }
      });
    }

    state = state.copyWith(
      projectState: AsyncValue.data(_projects),
      projectFilter: filter,
    );
  }

  fetchProjects(String categoryId) async {
    state = state.copyWith(projectState: AsyncValue.loading());
    String typeId = '${state.selectedType?.id}';
    if (state.selectedType?.id == 0) {
      if (state.selectedType?.type == '전체') {
        typeId = 'all';
      } else {
        typeId = 'best';
      }
    }

    final AsyncValue<List<CategoryItemModel>> _state = await AsyncValue.guard(() async {
      final resp = await ref.watch(categoryRepositoryProvider).getCategoryProjects(categoryId, typeId);
      return resp.projects;
    });

    state = state.copyWith(
      projectState: _state,
      projects: _state.value ?? [],
    );
  }
}

@riverpod
Future<List<ProjectType>> fetchTypeTabs(Ref ref) async {
  await Future.delayed(Duration(milliseconds: 500));
  return ref.read(categoryRepositoryProvider).getProjectTypes();
}

@riverpod
Future<CategoryModel> fetchCategoryProjects(Ref ref, String categoryId) async {
  final resp = await ref.watch(categoryRepositoryProvider).getProjectsByCategoryId(categoryId);
  return resp;
}

@riverpod
Future<CategoryModel> fetchCategoryProjectsByType(Ref ref, String categoryId) async {
  final vm = ref.watch(categoryViewModelProvider);
  String typeId = '${vm.selectedType?.id}';
  if (vm.selectedType?.id == 0) {
    if (vm.selectedType?.type == '전체') {
      typeId = 'all';
    } else {
      typeId = 'best';
    }
  }
  final resp = await ref.watch(categoryRepositoryProvider).getCategoryProjects(categoryId, typeId);
  return resp;
}