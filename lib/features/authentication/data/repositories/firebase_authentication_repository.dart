import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:social_network/core/errors/failures.dart';
import 'package:social_network/features/authentication/data/datasources_interfaces/firebase_authentication_datasource.dart';
import 'package:social_network/features/authentication/domain/repositories_interfaces/firebase_authentication_repository.dart';

import '../../constants.dart';

class FirebaseAuthenticationRepository
    implements IFirebaseAuthenticationRepository {
  @override
  Future<Either<IFailure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential =
          await Modular.get<IFirebaseAuthenticationDatasource>()
              .signInWithEmailAndPassword(email, password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(_getFailureByCode(e));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential =
          await Modular.get<IFirebaseAuthenticationDatasource>()
              .createUserWithEmailAndPassword(email, password);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(_getFailureByCode(e));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, void>> sendPasswordResetEmail(String email) async {
    try {
      return Right(await Modular.get<IFirebaseAuthenticationDatasource>()
          .sendPasswordResetEmail(email));
    } on FirebaseAuthException catch (e) {
      return Left(_getFailureByCode(e));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, void>> signOut() async {
    try {
      return Right(
          await Modular.get<IFirebaseAuthenticationDatasource>().signOut());
    } on FirebaseAuthException catch (e) {
      return Left(_getFailureByCode(e));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  IFailure _getFailureByCode(FirebaseAuthException e) {
    if (e.code.toLowerCase() == user_not_found) {
      return FirebaseAuthFailure(
          "Email não encontrado, você pode criar uma nova conta com este e-mail");
    }
    if (e.code.toLowerCase() == email_already_in_use) {
      return FirebaseAuthFailure(
          "Este email já tem uma conta vinculada, você pode solicitar um link para criar uma nova senha");
    } else {
      return FirebaseAuthFailure(e.message);
    }
  }
}
