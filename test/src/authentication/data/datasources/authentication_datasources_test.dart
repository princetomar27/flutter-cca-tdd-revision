import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tddtut/core/errors/exceptions.dart';
import 'package:tddtut/core/utils/constants.dart';
import 'package:tddtut/src/authentication/data/datasources/authentication_datasources.dart';
import 'package:tddtut/src/authentication/data/models/user_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationDatasource authDatasource;

  setUp(() {
    client = MockHttpClient();
    authDatasource = AuthenticationDatasourceImpl(client: client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'should complete successfully when statusCode is 200 || 201',
      () async {
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response("User created successfully", 201),
        );

        final createUserMethodCall = authDatasource.createUser;

        expect(
          createUserMethodCall(
            name: 'name',
            createdAt: 'createdAt',
            avatar: 'avatar',
          ),
          completes,
        );
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode(
              {
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test('should throw [APIException] when the status code is not 200 || 201',
        () {
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
        (_) async => http.Response('Invalid email address', 403),
      );

      final methodCall = authDatasource.createUser;

      expect(
        () => methodCall(
          createdAt: 'createdAt',
          name: 'name',
          avatar: 'avatar',
        ),
        throwsA(
          const APIException(
            message: 'Invalid email address',
            statusCode: 403,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('should return [User] when the response code is 200', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      final result = await authDatasource.getUsers();
      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(
            kBaseUrl,
            kGetUsersEndpoint,
          ))).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  test('should return APIException when statusCode is not 200', () {
    const tMessage = 'Internal Server Error';
    when(() => client.get(any())).thenAnswer(
      (_) async => http.Response(
        tMessage,
        500,
      ),
    );

    final methdoCall = authDatasource.getUsers;

    expect(
      () => methdoCall(),
      throwsA(
        const APIException(message: tMessage, statusCode: 500),
      ),
    );

    verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndpoint))).called(1);
    verifyNoMoreInteractions(client);
  });
}
