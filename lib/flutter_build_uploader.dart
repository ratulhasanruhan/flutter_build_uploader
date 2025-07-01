import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) async {
  final config = _getUploaderConfig();
  final isRelease = config['release'] ?? true;
  final useWhatsapp = config['whatsapp'] ?? true;

  final buildType = isRelease ? 'release' : 'debug';
  final apkPath = 'build/app/outputs/flutter-apk/app-$buildType.apk';
  final apk = File(apkPath);

  if (!apk.existsSync()) {
    print('❌ APK not found at $apkPath. Please build the APK first.');
    exit(1);
  }

  print('✅ APK found. Renaming...');
  final metadata = _getAppMetadata();
  final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
  final newName = '${metadata.name}-v${metadata.version}-$timestamp.apk';
  final exportDir = Directory('build/exports');
  if (!exportDir.existsSync()) exportDir.createSync(recursive: true);

  final newPath = p.join(exportDir.path, newName);
  final renamed = await apk.copy(newPath);
  print('📦 APK renamed to: ${renamed.path}');

  print('☁️ Uploading to GoFile.io...');
  final url = await uploadToFileIo(renamed);
  if (url == null) {
    print('❌ Upload failed.');
    exit(1);
  }
  print('✅ Uploaded! Link: $url');

  if (useWhatsapp) {
    print('💬 Opening WhatsApp Web...');
    openWhatsAppWeb('Here is the new build: $url');
  }

  if (Platform.isWindows) {
    final batFile = File('flutterapk.bat');
    if (!batFile.existsSync()) {
      print('🛠️ Generating flutterapk.bat script for easy re-use...');
      batFile.writeAsStringSync('''
@echo off
flutter build apk --release
if %errorlevel% neq 0 exit /b %errorlevel%
dart run flutter_build_uploader
pause
''');
      print('✅ Script created: flutterapk.bat');
      print(
        '📁 You can double-click it or run `flutterapk.bat` in CMD next time.',
      );
    }
  }
}

/// Uploads a file to the file.io temporary file hosting service.
///
/// Returns the URL of the uploaded file if successful.
Future<String?> uploadToFileIo(File file) async {
  final uri = Uri.parse('https://upload.gofile.io/uploadfile');
  final request = http.MultipartRequest('POST', uri);
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  final response = await request.send();
  final resBody = await response.stream.bytesToString();
  final data = jsonDecode(resBody);
  return data['data']['downloadPage'];
}

/// Opens WhatsApp Web with a pre-filled message.
void openWhatsAppWeb(String message) {
  final encoded = Uri.encodeComponent(message);
  final url = 'https://web.whatsapp.com/send?text=$encoded';

  if (Platform.isWindows) {
    Process.run('start', [url], runInShell: true);
  } else if (Platform.isMacOS) {
    Process.run('open', [url]);
  } else {
    Process.run('xdg-open', [url]);
  }
}

class _Metadata {
  final String name;
  final String version;
  _Metadata(this.name, this.version);
}

/// Retrieves the app metadata from pubspec.yaml.
_Metadata _getAppMetadata() {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final yaml = loadYaml(pubspec);
  final name = yaml['name'] ?? 'app';
  final version = yaml['version'] ?? '1.0.0';
  return _Metadata(name, version);
}

/// Retrieves the uploader configuration from pubspec.yaml.
Map _getUploaderConfig() {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final yaml = loadYaml(pubspec);
  if (yaml is YamlMap && yaml.containsKey('flutter_build_uploader')) {
    return Map.from(yaml['flutter_build_uploader']);
  }
  return {};
}
