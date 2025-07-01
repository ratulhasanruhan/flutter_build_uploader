import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_build_uploader/flutter_build_uploader.dart';

void main() {
  test('getAppMetadata reads name and version from pubspec.yaml', () {
    // Arrange: create a fake pubspec.yaml
    final pubspecContent = '''
name: test_app
version: 1.2.3
''';
    File('pubspec.yaml').writeAsStringSync(pubspecContent);

    // Act
    final metadata = getAppMetadata();

    // Assert
    expect(metadata.name, 'test_app');
    expect(metadata.version, '1.2.3');

    // Cleanup
    File('pubspec.yaml').deleteSync();
  });
}
