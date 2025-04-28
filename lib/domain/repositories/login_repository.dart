import 'package:dio/dio.dart';
import 'package:pos2/data/models/login_request.dart';
import 'package:pos2/data/models/login_response.dart';
import 'package:pos2/core/services/api_service.dart';

class LoginRepository {
  final ApiService _apiService;

  LoginRepository() : _apiService = ApiService(Dio());

  Future<LoginResponse> login(String email, String password) async {
    final LoginRequest loginRequest = LoginRequest(Email: email, Password: password);

    try {
      final LoginResponse response = await _apiService.login(loginRequest);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
