
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/category/category_model.dart';
import 'package:wabiz_app/service/category/category_api.dart';
import 'package:wabiz_app/service/category/category_api_service.dart';
import 'package:wabiz_app/shared/model/project_type.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(ref) {
  final service = ref.watch(categoryApiServiceProvider);
  return CategoryRepository(service);
}

class CategoryRepository {
  CategoryApiClient categoryApiClient;

  CategoryRepository(this.categoryApiClient);

  List<ProjectType> getProjectTypes() {
    List<ProjectType> defaultProjectType = [
      ProjectType(id: 1, type: '테크가전', imagePath: 'assets/icons/type/1.svg'),
      ProjectType(id: 2, type: '패션', imagePath: 'assets/icons/type/2.svg'),
      ProjectType(id: 3, type: '뷰티', imagePath: 'assets/icons/type/3.svg'),
      ProjectType(id: 4, type: '홈리빙', imagePath: 'assets/icons/type/4.svg'),
      ProjectType(id: 5, type: '스포츠아웃도어', imagePath: 'assets/icons/type/5.svg'),
      ProjectType(id: 6, type: '푸드', imagePath: 'assets/icons/type/6.svg'),
      ProjectType(id: 7, type: '도서 전자책', imagePath: 'assets/icons/type/7.svg'),
      ProjectType(id: 8, type: '클래스', imagePath: 'assets/icons/type/8.svg'),
    ];

    return [
      ProjectType(id: 0, type: '전체', imagePath: 'assets/icons/type/all.svg'),
      ProjectType(id: 0, type: 'BEST 펀딩', imagePath: 'assets/icons/type/best.svg'),
      ...defaultProjectType,
    ];
  }

  Future<CategoryModel> getCategoryProjects(String categoryId, String typeId) async {
    return await categoryApiClient.getProjectsByProjectType(categoryId, typeId);
  }

  Future<CategoryModel> getProjectsByCategoryId(String categoryId) async {
    return await categoryApiClient.getProjectsByCategoryId(categoryId);
  }
}