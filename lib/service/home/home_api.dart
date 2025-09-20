import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wabiz_app/model/home/home_model.dart';
part 'home_api.g.dart';

@RestApi(baseUrl: 'https://localhost:3000/api/v1')
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @GET('/home')
  Future<HomeModel> getHomeProjects();
}

