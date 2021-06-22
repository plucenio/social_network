import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_network/core/errors/failures.dart';

abstract class IFirebaseAuthenticationRepository {
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<IFailure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password);

  Future<Either<IFailure, void>> sendPasswordResetEmail(String email);

  Future<Either<IFailure, void>> signOut();
}
