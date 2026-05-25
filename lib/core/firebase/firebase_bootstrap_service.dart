import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/firebase_options.dart';

class FirebaseBootstrapService extends GetxService {
  bool isEnabled = false;

  Future<FirebaseBootstrapService> init() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      isEnabled = true;
    } catch (_) {
      isEnabled = false;
    }
    return this;
  }
}
