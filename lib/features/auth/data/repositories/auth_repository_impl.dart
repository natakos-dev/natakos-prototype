import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    firebase_auth.FirebaseAuth.instance,
    GoogleSignIn(
      clientId:
          '361465341910-otgm5r3mh2gbvvkkuhnt4cc073ja39dt.apps.googleusercontent.com',
    ),
  );
}

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn);

  @override
  User? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return User(uid: user.uid, email: user.email ?? '');
  }

  @override
  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      return User(uid: user.uid, email: user.email ?? '');
    });
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        return left(const ServerFailure('User not found after login'));
      }
      return right(User(uid: user.uid, email: user.email ?? ''));
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(ServerFailure(e.message ?? 'Authentication failed'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> registerWithEmailPassword(
      String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        return left(const ServerFailure('User not created'));
      }
      return right(User(uid: user.uid, email: user.email ?? ''));
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(ServerFailure(e.message ?? 'Registration failed'));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in flow
        return left(const ServerFailure('Sign in canceled'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return left(const ServerFailure('User not found after Google login'));
      }
      return right(User(uid: user.uid, email: user.email ?? ''));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
