import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenx/screenx.dart';
import 'package:spend_analytics/core/services/biometric_lock_service.dart';

/// Full-screen frosted-glass lock overlay shown on app resume.
/// Cannot be dismissed — only unlocked via biometric.
class BiometricLockScreen extends StatefulWidget {
  const BiometricLockScreen({super.key});

  @override
  State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}

class _BiometricLockScreenState extends State<BiometricLockScreen> {
  bool _isAuthenticating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Auto-trigger on first show
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryAuthenticate());
  }

  Future<void> _tryAuthenticate() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
      _errorMessage = null;
    });

    final service = Get.find<BiometricLockService>();
    final success = await service.authenticate();

    if (!mounted) return;
    if (success) {
      Get.back<void>();
    } else {
      setState(() {
        _isAuthenticating = false;
        _errorMessage = 'Authentication failed. Tap to try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false, // Prevent back-button dismissal
      child: Scaffold(
        backgroundColor: scheme.surface,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                scheme.primary.withValues(alpha: 0.15),
                scheme.surface,
                scheme.secondary.withValues(alpha: 0.10),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenX.dp(32)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // App logo / lock icon
                    Container(
                      width: ScreenX.dp(96),
                      height: ScreenX.dp(96),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: scheme.primary.withValues(alpha: 0.12),
                        border: Border.all(
                          color: scheme.primary.withValues(alpha: 0.25),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.lock_rounded,
                        size: ScreenX.dp(44),
                        color: scheme.primary,
                      ),
                    ),
                    SizedBox(height: ScreenX.dp(28)),
                    Text(
                      'Spend Analytics',
                      style: TextStyle(
                        fontSize: ScreenX.sp(26),
                        fontWeight: FontWeight.w800,
                        color: scheme.onSurface,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: ScreenX.dp(8)),
                    Text(
                      'Verify your identity to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenX.sp(14),
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: ScreenX.dp(48)),
                    if (_isAuthenticating)
                      CircularProgressIndicator(
                        color: scheme.primary,
                        strokeWidth: 2.5,
                      )
                    else
                      GestureDetector(
                        onTap: _tryAuthenticate,
                        child: Container(
                          width: ScreenX.dp(72),
                          height: ScreenX.dp(72),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: scheme.primary.withValues(alpha: 0.14),
                            border: Border.all(
                              color: scheme.primary.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.fingerprint_rounded,
                            size: ScreenX.dp(38),
                            color: scheme.primary,
                          ),
                        ),
                      ),
                    if (_errorMessage != null) ...<Widget>[
                      SizedBox(height: ScreenX.dp(20)),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenX.sp(13),
                          color: scheme.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    SizedBox(height: ScreenX.dp(20)),
                    if (!_isAuthenticating)
                      TextButton(
                        onPressed: _tryAuthenticate,
                        child: Text(
                          'Unlock with Biometric',
                          style: TextStyle(
                            fontSize: ScreenX.sp(14),
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
