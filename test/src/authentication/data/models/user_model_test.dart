import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddtut/core/utils/typedefs.dart';
import 'package:tddtut/src/authentication/data/models/user_model.dart';
import 'package:tddtut/src/authentication/domain/entities/user.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclass of [User] entity', () {
    // Act
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with right data', () {
      // // Act
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson ', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a Map with User data', () {
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a Json with User data', () {
      final result = tModel.toJson();

      final tJson = jsonEncode({
        "id": "1",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt"
      });
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return true on comparing copyWith', () {
      final result = tModel.copyWith(name: "Prince");
      expect(result.name, equals('Prince'));
    });

    test('should return false on comparing value updated by copyWith', () {
      final result = tModel.copyWith(name: "Prince");
      expect(result.name, equals("Dane"));
    });
  });
}
