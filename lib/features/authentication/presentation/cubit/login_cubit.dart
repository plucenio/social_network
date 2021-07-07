import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:social_network/features/authentication/domain/usecases/usecases.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  void signIn(String email, String password) async {
    IFirebaseAuthenticationUsecase usecase =
        Modular.get<IFirebaseAuthenticationUsecase>();
    try {
      emit(LoadingState());
      (await usecase.signInWithEmailAndPassword(email, password)).fold(
        (l) => emit(ErrorState(l.message)),
        (r) => emit(LoadedState('Sucesso')),
      );
    } catch (e) {
      emit(ErrorState('Uma falha ocorreu'));
    }
  }

  void forget(String email) async {
    IFirebaseAuthenticationUsecase usecase =
        Modular.get<IFirebaseAuthenticationUsecase>();
    try {
      emit(LoadingState());
      (await usecase.sendPasswordResetEmail(email)).fold(
        (l) => emit(ErrorState(l.message)),
        (r) => emit(LoadedState('Um link foi enviado para o seu email.')),
      );
    } catch (e) {
      emit(ErrorState('Uma falha ocorreu'));
    }
  }

  void create(String email, String password) async {
    IFirebaseAuthenticationUsecase usecase =
        Modular.get<IFirebaseAuthenticationUsecase>();
    try {
      emit(LoadingState());
      (await usecase.createUserWithEmailAndPassword(email, password)).fold(
        (l) => emit(ErrorState(l.message)),
        (r) async {
          await usecase.sendPasswordResetEmail(email);
          emit(LoadedState('Um link foi enviado para o seu email.'));
        },
      );
    } catch (e) {
      emit(ErrorState('Uma falha ocorreu'));
    }
  }
}
