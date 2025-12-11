import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmailPassword(
      String email, String password);
  Future<Either<Failure, User>> registerWithEmailPassword(
      String email, String password);
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, void>> logout();
  Stream<User?> get authStateChanges;
  User? get currentUser;
}
