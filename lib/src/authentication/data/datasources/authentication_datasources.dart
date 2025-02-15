import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/typedefs.dart';
import '../models/user_model.dart';

abstract class AuthenticationDatasource {
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  Future<List<UserModel>> getUsers();
}

const kCreateUserEndpoint = "/test-api/users";
const kGetUsersEndpoint = "/test-api/user";

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final http.Client client;
  AuthenticationDatasourceImpl({required this.client});

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await client.post(
        Uri.parse('$kBaseUrl/$kCreateUserEndpoint'),
        body: jsonEncode(
          {
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          },
        ),
      );

      if (response.statusCode != 200 || response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await client.get(
        Uri.https(kBaseUrl, kGetUsersEndpoint),
      );
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ServerException {
      throw const ServerException(
          message: 'Internal Server Error', statusCode: 500);
    } on APIException {
      rethrow;
    } catch (error) {
      throw APIException(message: error.toString(), statusCode: 501);
    }
  }
}
