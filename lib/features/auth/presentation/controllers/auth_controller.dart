import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
Stream<User?> authState(AuthStateRef ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {
    // nothing to initialize
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.loginWithEmailPassword(email, password);
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => const AsyncData(null),
    );
  }

  Future<void> register(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.registerWithEmailPassword(email, password);
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => const AsyncData(null),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithGoogle();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => const AsyncData(null),
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.logout();
    state = result.fold(
      (l) => AsyncError(l.message, StackTrace.current),
      (r) => const AsyncData(null),
    );
  }
}
