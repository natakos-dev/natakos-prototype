import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/providers/shared_prefs_provider.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkState();
  }

  Future<void> _checkState() async {
    // Artificial delay for splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Ensure providers are ready
    if (!mounted) return;

    final prefs = await ref.read(sharedPreferencesProvider.future);
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    final authState = ref.read(authStateProvider);

    // If auth state is loading, wait for it (async value)
    // Actually authStateProvider is a stream. We can check current value.

    // Simple logic:
    // 1. If not seen onboarding -> /onboarding
    // 2. If seen onboarding:
    //    - If logged in -> /
    //    - If not logged in -> /login

    final user = authState.valueOrNull;

    // TEMP: Bypass auth check for development
    // if (mounted) context.go('/');
    if (!seenOnboarding) {
      if (mounted) context.go('/onboarding');
    } else {
      if (user != null) {
        if (mounted) context.go('/');
      } else {
        if (mounted) context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary, // Facebook Blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_work_rounded,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              'NataKos',
              style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
