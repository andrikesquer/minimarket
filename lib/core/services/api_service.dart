import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:pos2/data/models/login_request.dart';
import 'package:pos2/data/models/login_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://appimobile.adssystems.com.mx/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('api/login/AppLogin')
  Future<LoginResponse> login(@Body() LoginRequest request);
}
