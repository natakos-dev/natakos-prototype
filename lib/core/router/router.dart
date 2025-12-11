import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/tenants/presentation/screens/tenant_detail_screen.dart';
import '../../features/rooms/presentation/screens/add_room_screen.dart';
import '../../features/rooms/presentation/screens/add_room_type_screen.dart';
import '../../features/rooms/presentation/screens/room_type_list_screen.dart';
import '../../features/tenants/presentation/screens/add_tenant_screen.dart';
import '../../features/settings/presentation/screens/starter_form_screen.dart';
import '../../features/rooms/data/models/room_type_model.dart';
import '../../features/finance/presentation/screens/add_transaction_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final hasError = authState.hasError;
      final isAuthenticated = authState.valueOrNull != null;

      final isSplash = state.uri.toString() == '/splash';
      final isOnboarding = state.uri.toString() == '/onboarding';
      final isLogin = state.uri.toString() == '/login';
      final isRegister = state.uri.toString() == '/register';

      if (isSplash || isOnboarding) return null;

      // Authentication Logic
      if (isLoading || hasError) return null;
      if (!isAuthenticated) {
        return (isLogin || isRegister) ? null : '/login';
      }
      if (isLogin) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/tenant-detail',
        builder: (context, state) {
          final tenant = state.extra
              as dynamic; // casting dynamic for now to avoid import chaos if fast
          return TenantDetailScreen(tenant: tenant);
        },
      ),
      GoRoute(
        path: '/add-room',
        builder: (context, state) => const AddRoomScreen(),
      ),
      GoRoute(
        path: '/add-room-type',
        builder: (context, state) {
          final extra = state.extra as RoomTypeModel?;
          return AddRoomTypeScreen(initialData: extra);
        },
      ),
      GoRoute(
        path: '/room-types',
        builder: (context, state) => const RoomTypeListScreen(),
      ),
      GoRoute(
        path: '/add-tenant',
        builder: (context, state) => const AddTenantScreen(),
      ),
      GoRoute(
        path: '/starter-form',
        builder: (context, state) => const StarterFormScreen(),
      ),
      GoRoute(
        path: '/add-transaction',
        builder: (context, state) => const AddTransactionScreen(),
      ),
    ],
  );
}
