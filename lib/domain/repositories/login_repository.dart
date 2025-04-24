import 'package:dio/dio.dart';
import 'package:pos2/data/models/login_model.dart';
import 'package:pos2/data/models/user_model.dart';
import 'package:pos2/core/services/api_service.dart';

class LoginRepository {
  final ApiService _apiService;

  LoginRepository() : _apiService = ApiService(Dio());

  Future<LoginResponse> login(String email, String password) async {
    final loginRequest = LoginRequest(Email: email, Password: password);

    try {
      final response = await _apiService.login(loginRequest);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
