// lib/services/api_service.dart
import 'package:dio/dio.dart';
import '../models/user.dart';

class ApiService {
  final String baseUrl = 'https://reqres.in/api';
  final Dio _dio = Dio();

  ApiService() {
    // ⚠️ No se agrega Authorization → reqres.in no lo necesita
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get('$baseUrl/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('🚫 Acceso denegado: verifique autenticación');
      } else if (e.response?.statusCode == 404) {
        throw Exception('🔍 Recurso no encontrado');
      } else {
        throw Exception('❌ Error de red: ${e.message}');
      }
    } catch (e) {
      throw Exception('❌ Error desconocido: $e');
    }
  }

  Future<User> createUser(User user) async {
    try {
      final response = await _dio.post('$baseUrl/users', data: user.toJson());

      if (response.statusCode == 201 || response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('❌ Error al crear: ${e.message}');
      // Agregar más detalles aquí si es necesario
    } catch (e) {
      throw Exception('❌ Error desconocido: $e');
    }
  }
}