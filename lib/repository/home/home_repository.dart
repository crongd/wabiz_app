import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wabiz_app/model/home/home_model.dart';
import 'package:wabiz_app/service/home/home_api.dart';
import 'package:wabiz_app/service/home/home_api_service.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(ref) {
  final service = ref.watch(homeApiServiceProvider);
  return HomeRepository(service);
}

class HomeRepository {
  HomeApi homeApiService;

  HomeRepository(this.homeApiService);

  Future<HomeModel> getHomeProjects() async {
    final result = await homeApiService.getHomeProjects();
    return result;
  }
}