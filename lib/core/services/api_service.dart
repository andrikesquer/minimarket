import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:pos2/data/models/user_model.dart';
import 'package:pos2/data/models/login_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://appimobile.adssystems.com.mx/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('api/login/AppLogin')
  Future<LoginResponse> login(@Body() LoginRequest request);
}
