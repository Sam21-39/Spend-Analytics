import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenx/screenx.dart';
import 'package:spend_analytics/core/local_db/app_database.dart';
import 'package:spend_analytics/core/services/biometric_lock_service.dart';
import 'package:spend_analytics/core/supabase/supabase_service.dart';
import 'package:spend_analytics/core/theme/app_theme.dart';
import 'package:spend_analytics/core/theme/theme_service.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/auth/login_screen.dart';
import 'package:spend_analytics/features/categories/category_controller.dart';
import 'package:spend_analytics/features/dashboard/dashboard_controller.dart';
import 'package:spend_analytics/features/dashboard/dashboard_screen.dart';
import 'package:spend_analytics/features/transactions/add_transaction_screen.dart';
import 'package:spend_analytics/features/transactions/transaction_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_analytics/shared/models/transaction_model.dart';
import 'package:spend_analytics/core/firebase/analytics_service.dart';
import 'package:spend_analytics/core/firebase/crashlytics_service.dart';
import 'package:image/image.dart' as img;

// ── HttpOverrides Mock to bypass Upgrader network requests and mock fonts ────
class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async => _FakeHttpClientRequest();

  @override
  set autoUncompress(bool value) {}
}

class _FakeHttpClientRequest extends Fake implements HttpClientRequest {
  @override
  final headers = _FakeHttpHeaders();

  @override
  bool followRedirects = true;

  @override
  int maxRedirects = 5;

  @override
  bool persistentConnection = true;

  @override
  int contentLength = 0;

  @override
  Encoding encoding = utf8;

  @override
  void add(List<int> data) {}

  @override
  void write(Object? object) {}

  @override
  void writeAll(Iterable objects, [String separator = ""]) {}

  @override
  void writeCharCode(int charCode) {}

  @override
  void writeln([Object? object = ""]) {}

  @override
  Future addStream(Stream<List<int>> stream) async {}

  @override
  Future flush() async {}

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();
}

class _FakeHttpHeaders extends Fake implements HttpHeaders {
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {}
  @override
  String? value(String name) => null;
  @override
  List<String>? operator [](String name) => null;
  @override
  ContentType? get contentType => null;
  @override
  void forEach(void Function(String name, List<String> values) action) {}
}

class _FakeHttpClientResponse extends Fake implements HttpClientResponse {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  int get statusCode => 200;

  @override
  int get contentLength {
    final file = File('assets/fonts/Roboto-Regular.ttf');
    return file.lengthSync();
  }

  @override
  bool get isRedirect => false;

  @override
  bool get persistentConnection => true;

  @override
  List<RedirectInfo> get redirects => const <RedirectInfo>[];

  @override
  String get reasonPhrase => 'OK';

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    // Intercept with the local Roboto font file bytes to satisfy GoogleFonts
    final file = File('assets/fonts/Roboto-Regular.ttf');
    final bytes = file.readAsBytesSync();
    final stream = Stream<List<int>>.value(bytes);
    return stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

// ── Fake Dependencies ────────────────────────────────────────────────────────
class FakeSupabaseService extends GetxService implements SupabaseService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool get isEnabled => false;
  @override
  bool get isAuthenticated => false;
  @override
  String? get currentUserId => null;
}

class FakeAnalyticsService extends GetxService implements AnalyticsService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) async {}
}

class FakeCrashlyticsService extends GetxService implements CrashlyticsService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object>? information,
    bool? printDetails,
    bool? fatal,
    Map<String, Object?>? customKeys,
  }) async {}
}

class FakeAppDatabase extends GetxService implements AppDatabase {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Stream<List<TransactionModel>> watchTransactionsForUser(String userId) {
    return Stream.value(<TransactionModel>[]);
  }

  @override
  Future<List<TransactionModel>> allTransactionsForUser(String userId) async {
    return <TransactionModel>[];
  }
}

class FakeBiometricLockService extends GetxService implements BiometricLockService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  bool get shouldLock => false;
}

class FakeThemeService extends GetxService implements ThemeService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  final themeMode = ThemeMode.light.obs;
  @override
  String get themeLabel => 'Light';
}

class FakeCategoryController extends GetxController implements CategoryController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  final expenseCategories =
      <String>['Food', 'Groceries', 'Rent', 'Transport', 'Shopping', 'Bills', 'Entertainment'].obs;
  @override
  final incomeCategories = <String>['Salary', 'Freelance', 'Investments'].obs;
  @override
  final transferCategories = <String>['Transfer'].obs;
  @override
  RxList<String> get categories => expenseCategories;

  @override
  List<String> categoriesForType(String type) {
    if (type == 'income') return incomeCategories;
    if (type == 'transfer') return transferCategories;
    return expenseCategories;
  }
}

class FakeAuthController extends GetxController implements AuthController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  final isLoading = false.obs;
  @override
  final isLoggedIn = false.obs;
  @override
  bool get hasActiveSession => false;
  @override
  Future<void> signInWithGoogle() async {}
  @override
  Future<void> continueAsGuest() async {}

  @override
  String resolveActiveUserId() => 'user';
}

class FakeDashboardController extends GetxController implements DashboardController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  final transactions = <TransactionModel>[].obs;
  @override
  final monthlySpend = 0.0.obs;
  @override
  final isGuestMode = false.obs;
  @override
  final isLoading = false.obs;
  @override
  final firstName = 'Rahul'.obs;

  @override
  Future<void> refreshDashboard() async {}
}

class FakeTransactionController extends GetxController implements TransactionController {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  final isLoading = false.obs;

  @override
  Future<void> saveTransaction(TransactionModel txn, {required bool isUpdate}) async {}
}

// ── Feature Graphic Design Widget ───────────────────────────────────────────
class FeatureGraphicWidget extends StatelessWidget {
  const FeatureGraphicWidget({super.key, required this.isDark, required this.dashboardScreen});

  final bool isDark;
  final Widget dashboardScreen;

  @override
  Widget build(BuildContext context) {
    final theme = isDark ? AppTheme.dark : AppTheme.light;
    final scheme = theme.colorScheme;

    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: Container(
          width: 1024,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isDark
                      ? <Color>[
                        const Color(0xFF0F172A),
                        const Color(0xFF1E1B4B),
                        const Color(0xFF1E293B),
                      ]
                      : <Color>[
                        const Color(0xFFF8FAFC),
                        const Color(0xFFEEF2F6),
                        const Color(0xFFE2E8F0),
                      ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              // Decorative background shapes
              Positioned(
                top: -100,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.primary.withValues(alpha: isDark ? 0.15 : 0.08),
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                right: 350,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.secondary.withValues(alpha: isDark ? 0.12 : 0.06),
                  ),
                ),
              ),

              // Content Layout
              Row(
                children: <Widget>[
                  // Left side: Text & Branding
                  Expanded(
                    flex: 12,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 64, top: 60, bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Logo & Brand Name
                          Row(
                            children: <Widget>[
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [scheme.primary, scheme.secondary],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.analytics_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Spend Analytics',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: scheme.onSurface,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Take Control of\nYour Wealth.',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              height: 1.15,
                              color: scheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Secure, offline-first wealth tracking with glassmorphic UI, real-time analytics & limits.',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 36),
                          // Feature tags
                          Row(
                            children: <Widget>[
                              _buildTag('Offline-First', scheme),
                              const SizedBox(width: 10),
                              _buildTag('Biometric Safe', scheme),
                              const SizedBox(width: 10),
                              _buildTag('Smart Limits', scheme),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right side: Angled Mockup
                  Expanded(
                    flex: 10,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        Positioned(
                          right: -80,
                          top: 40,
                          child: Transform(
                            transform:
                                Matrix4.identity()
                                  ..setEntry(3, 2, 0.001) // perspective
                                  ..rotateX(0.05)
                                  ..rotateY(-0.35)
                                  ..rotateZ(0.08),
                            alignment: FractionalOffset.center,
                            child: Container(
                              width: 330,
                              height: 580,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: isDark ? 0.6 : 0.25),
                                    blurRadius: 40,
                                    offset: const Offset(-20, 20),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: Container(
                                  color: scheme.surface,
                                  child: MediaQuery(
                                    data: const MediaQueryData(
                                      size: Size(330, 580),
                                      devicePixelRatio: 2.0,
                                      padding: EdgeInsets.only(top: 24, bottom: 12),
                                    ),
                                    child: dashboardScreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text, ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: scheme.primary,
        ),
      ),
    );
  }
}

// ── Widget Test Suite ────────────────────────────────────────────────────────
void main() {
  setUpAll(() async {
    // Ensure the test binding is initialized before loading fonts
    TestWidgetsFlutterBinding.ensureInitialized();

    // Set mock initial values for shared_preferences to prevent MissingPluginException
    SharedPreferences.setMockInitialValues({});

    // Tell AppTheme to bypass GoogleFonts in test environment
    AppTheme.useGoogleFonts = false;

    // Disable Google Fonts runtime network fetching
    GoogleFonts.config.allowRuntimeFetching = false;

    // Load local font files into the Flutter test engine.
    // Map Inter (used by text theme) to local Roboto TTF files to avoid blank square text.
    final fontFamilies = {
      'Roboto': [
        'assets/fonts/Roboto-Regular.ttf',
        'assets/fonts/Roboto-Medium.ttf',
        'assets/fonts/Roboto-Bold.ttf',
        'assets/fonts/Roboto-Black.ttf',
      ],
      'Inter': [
        'assets/fonts/Roboto-Regular.ttf',
        'assets/fonts/Roboto-Medium.ttf',
        'assets/fonts/Roboto-Bold.ttf',
        'assets/fonts/Roboto-Black.ttf',
      ],
    };

    for (final entry in fontFamilies.entries) {
      final loader = FontLoader(entry.key);
      for (final path in entry.value) {
        final file = File(path);
        if (file.existsSync()) {
          final bytes = file.readAsBytesSync();
          loader.addFont(Future.value(bytes.buffer.asByteData(bytes.offsetInBytes, bytes.lengthInBytes)));
        }
      }
      await loader.load();
    }

    // Load MaterialIcons from the Flutter SDK artifacts cache
    try {
      final flutterRoot = Platform.environment['FLUTTER_ROOT'];
      stderr.writeln('DEBUG: FLUTTER_ROOT is $flutterRoot');
      if (flutterRoot != null) {
        final fontFile = File('$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf');
        stderr.writeln('DEBUG: fontFile path is ${fontFile.path}, exists: ${fontFile.existsSync()}');
        if (fontFile.existsSync()) {
          final bytes = fontFile.readAsBytesSync();
          final materialLoader = FontLoader('MaterialIcons');
          materialLoader.addFont(Future.value(bytes.buffer.asByteData(bytes.offsetInBytes, bytes.lengthInBytes)));
          await materialLoader.load();
          stderr.writeln('DEBUG: Loaded MaterialIcons font successfully');
        } else {
          stderr.writeln('Warning: MaterialIcons font file not found at ${fontFile.path}');
        }
      } else {
        stderr.writeln('Warning: FLUTTER_ROOT environment variable not found');
      }
    } catch (e) {
      print('Warning: Failed to load MaterialIcons font in test: $e');
    }
  });

  setUp(() {
    // Override HttpOverrides inside setUp to prevent test framework from overriding it
    HttpOverrides.global = TestHttpOverrides();

    // Intercept and ignore RenderFlex layout overflow errors in test outputs.
    // Constrained screenshot dimensions and test font rendering often cause minor overflows.
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      final msg = details.toString().toLowerCase();
      if (msg.contains('overflow') || msg.contains('renderflex')) {
        return;
      }
      originalOnError?.call(details);
    };

    // Populate fake DI before EACH test starts
    Get.put<SupabaseService>(FakeSupabaseService(), permanent: true);
    Get.put<AnalyticsService>(FakeAnalyticsService(), permanent: true);
    Get.put<CrashlyticsService>(FakeCrashlyticsService(), permanent: true);
    Get.put<AppDatabase>(FakeAppDatabase(), permanent: true);
    Get.put<BiometricLockService>(FakeBiometricLockService(), permanent: true);
    Get.put<ThemeService>(FakeThemeService(), permanent: true);
    Get.put<CategoryController>(FakeCategoryController(), permanent: true);
    Get.put<AuthController>(FakeAuthController(), permanent: true);
    Get.put<DashboardController>(FakeDashboardController(), permanent: true);
    Get.put<TransactionController>(FakeTransactionController(), permanent: true);
  });

  tearDown(() {
    Get.reset();
  });

  group('Promo Assets Generation', () {
    final boundaryKey = GlobalKey();

    Widget buildTestApp({required Widget child, required ThemeMode themeMode}) {
      return GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        debugShowCheckedModeBanner: false,
        home: ScreenXLayout(child: RepaintBoundary(key: boundaryKey, child: child)),
      );
    }

    Future<void> capture(
      WidgetTester tester,
      String filename, {
      double? pixelRatio,
      Size? targetSize,
    }) async {
      await tester.pumpAndSettle();
      await tester.runAsync(() async {
        final boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

        // If targetSize is provided, we supersample (render at 3x target size and resize down)
        final ratio = targetSize != null ? 3.0 : (pixelRatio ?? tester.view.devicePixelRatio);
        final image = await boundary.toImage(pixelRatio: ratio);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        var pngBytes = byteData!.buffer.asUint8List();

        if (targetSize != null) {
          final decoded = img.decodePng(pngBytes);
          if (decoded != null) {
            final resized = img.copyResize(
              decoded,
              width: targetSize.width.toInt(),
              height: targetSize.height.toInt(),
              interpolation: img.Interpolation.cubic,
            );
            pngBytes = Uint8List.fromList(img.encodePng(resized));
          }
        }

        final file = File('promo/$filename');
        stderr.writeln('DEBUG: file.absolute.path is: ${file.absolute.path}');
        await file.parent.create(recursive: true);
        await file.writeAsBytes(pngBytes);
        stderr.writeln('Generated promo asset: ${file.absolute.path} (ratio: $ratio)');
      });
    }

    // Populate realistic dashboard data
    void setupMockDashboardData() {
      final now = DateTime.now();
      final controller = Get.find<DashboardController>() as FakeDashboardController;
      controller.firstName.value = 'Rahul';
      controller.isGuestMode.value = false;
      controller.isLoading.value = false;
      controller.monthlySpend.value = 354.39;

      controller.transactions.assignAll(<TransactionModel>[
        TransactionModel(
          id: '1',
          userId: 'user',
          amount: 124.50,
          type: 'expense',
          category: 'Food',
          paymentMode: 'Card',
          transactionDate: now.subtract(const Duration(minutes: 1)),
          updatedAt: now,
          note: 'Whole Foods organic groceries',
        ),
        TransactionModel(
          id: '2',
          userId: 'user',
          amount: 24.00,
          type: 'expense',
          category: 'Transport',
          paymentMode: 'UPI',
          transactionDate: now.subtract(const Duration(minutes: 5)),
          updatedAt: now,
          note: 'Uber to work',
        ),
        TransactionModel(
          id: '3',
          userId: 'user',
          amount: 15.99,
          type: 'expense',
          category: 'Entertainment',
          paymentMode: 'Card',
          transactionDate: now.subtract(const Duration(minutes: 10)),
          updatedAt: now,
          note: 'Netflix Premium subscription',
        ),
        TransactionModel(
          id: '4',
          userId: 'user',
          amount: 189.90,
          type: 'expense',
          category: 'Shopping',
          paymentMode: 'Card',
          transactionDate: now.subtract(const Duration(minutes: 15)),
          updatedAt: now,
          note: 'Zara new jacket',
        ),
      ]);
    }

    testWidgets('Generate Login Screen Mobile Screenshots', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        final msg = details.toString().toLowerCase();
        if (msg.contains('overflow') || msg.contains('renderflex')) return;
        originalOnError?.call(details);
      };

      // Set mobile size
      tester.view.physicalSize = const Size(1080, 2280);
      tester.view.devicePixelRatio = 3.0;

      // Light Mode
      await tester.pumpWidget(buildTestApp(child: const LoginScreen(), themeMode: ThemeMode.light));
      await capture(tester, 'login_light_mobile.png');

      // Dark Mode
      await tester.pumpWidget(buildTestApp(child: const LoginScreen(), themeMode: ThemeMode.dark));
      await capture(tester, 'login_dark_mobile.png');
    });

    testWidgets('Generate Dashboard Screen Screenshots (Mobile & Tablet)', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        final msg = details.toString().toLowerCase();
        if (msg.contains('overflow') || msg.contains('renderflex')) return;
        originalOnError?.call(details);
      };

      setupMockDashboardData();

      // --- MOBILE SIZES ---
      tester.view.physicalSize = const Size(1080, 2280);
      tester.view.devicePixelRatio = 3.0;

      // Light Mobile
      await tester.pumpWidget(
        buildTestApp(child: const DashboardScreen(), themeMode: ThemeMode.light),
      );
      await capture(tester, 'dashboard_light_mobile.png');

      // Dark Mobile
      await tester.pumpWidget(
        buildTestApp(child: const DashboardScreen(), themeMode: ThemeMode.dark),
      );
      await capture(tester, 'dashboard_dark_mobile.png');

      // --- TABLET SIZES ---
      tester.view.physicalSize = const Size(2048, 2732);
      tester.view.devicePixelRatio = 2.0;

      // Light Tablet
      await tester.pumpWidget(
        buildTestApp(child: const DashboardScreen(), themeMode: ThemeMode.light),
      );
      await capture(tester, 'dashboard_light_tablet.png');

      // Dark Tablet
      await tester.pumpWidget(
        buildTestApp(child: const DashboardScreen(), themeMode: ThemeMode.dark),
      );
      await capture(tester, 'dashboard_dark_tablet.png');
    });

    testWidgets('Generate Add Transaction Screen Screenshots (Mobile & Tablet)', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        final msg = details.toString().toLowerCase();
        if (msg.contains('overflow') || msg.contains('renderflex')) return;
        originalOnError?.call(details);
      };

      // --- MOBILE SIZES ---
      tester.view.physicalSize = const Size(1080, 2280);
      tester.view.devicePixelRatio = 3.0;

      // Light Mobile
      await tester.pumpWidget(
        buildTestApp(child: const AddTransactionScreen(), themeMode: ThemeMode.light),
      );
      await capture(tester, 'add_transaction_light_mobile.png');

      // Dark Mobile
      await tester.pumpWidget(
        buildTestApp(child: const AddTransactionScreen(), themeMode: ThemeMode.dark),
      );
      await capture(tester, 'add_transaction_dark_mobile.png');

      // --- TABLET SIZES ---
      tester.view.physicalSize = const Size(2048, 2732);
      tester.view.devicePixelRatio = 2.0;

      // Light Tablet
      await tester.pumpWidget(
        buildTestApp(child: const AddTransactionScreen(), themeMode: ThemeMode.light),
      );
      await capture(tester, 'add_transaction_light_tablet.png');

      // Dark Tablet
      await tester.pumpWidget(
        buildTestApp(child: const AddTransactionScreen(), themeMode: ThemeMode.dark),
      );
      await capture(tester, 'add_transaction_dark_tablet.png');
    });

    testWidgets('Generate Feature Graphic Banners (1024x500)', (tester) async {
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        final msg = details.toString().toLowerCase();
        if (msg.contains('overflow') || msg.contains('renderflex')) return;
        originalOnError?.call(details);
      };

      setupMockDashboardData();

      // Feature Graphic must be exactly 1024 x 500
      tester.view.physicalSize = const Size(1024, 500);
      tester.view.devicePixelRatio = 1.0;

      // Light Mode Feature Graphic
      await tester.pumpWidget(
        buildTestApp(
          child: const FeatureGraphicWidget(isDark: false, dashboardScreen: DashboardScreen()),
          themeMode: ThemeMode.light,
        ),
      );
      await capture(tester, 'feature_graphic_light.png', targetSize: const Size(1024, 500));

      // Dark Mode Feature Graphic
      await tester.pumpWidget(
        buildTestApp(
          child: const FeatureGraphicWidget(isDark: true, dashboardScreen: DashboardScreen()),
          themeMode: ThemeMode.dark,
        ),
      );
      await capture(tester, 'feature_graphic_dark.png', targetSize: const Size(1024, 500));
    });
  });
}
