import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:social_network/features/authentication/presentation/cubit/login_cubit.dart';

import 'features/authentication/data/datasources_interfaces/firebase_authentication_datasource.dart';
import 'features/authentication/data/repositories/firebase_authentication_repository.dart';
import 'features/authentication/domain/repositories_interfaces/firebase_authentication_repository.dart';
import 'features/authentication/domain/usecases/firebase_authentication_usecase.dart';
import 'features/authentication/external/firebase_authentication_datasource.dart';
import 'features/authentication/presentation/pages/create_account_page.dart';
import 'features/authentication/presentation/pages/logged_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<IFirebaseAuthenticationDatasource>(
        (i) => FirebaseAuthenticationDatasource()),
    Bind<IFirebaseAuthenticationRepository>(
        (i) => FirebaseAuthenticationRepository()),
    Bind<IFirebaseAuthenticationUsecase>(
        (i) => FirebaseAuthenticationUsecase()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => BlocProvider(
        create: (_) => LoginCubit(),
        child: LoginPage(),
      ),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      CreateAccountPage.route,
      child: (context, args) => BlocProvider(
        create: (_) => LoginCubit(),
        child: CreateAccountPage(),
      ),
      transition: TransitionType.fadeIn,
    ),
    ChildRoute(
      LoggedPage.route,
      child: (_, __) => LoggedPage(),
      transition: TransitionType.fadeIn,
    ),
  ];
}
