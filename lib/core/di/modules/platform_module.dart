import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:speech_to_text/speech_to_text.dart';

@module
abstract class PlatformModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      );

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  LocalAuthentication get localAuth => LocalAuthentication();

  @lazySingleton
  SpeechToText get speechToText => SpeechToText();
}
