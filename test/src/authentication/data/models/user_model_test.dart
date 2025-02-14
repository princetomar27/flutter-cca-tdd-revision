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
}
