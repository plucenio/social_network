
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'features/authentication/data/datasources_interfaces/firebase_authentication_datasource.dart';
import 'features/authentication/data/repositories/firebase_authentication_repository.dart';
import 'features/authentication/domain/repositories_interfaces/firebase_authentication_repository.dart';
import 'features/authentication/domain/usecases/firebase_authentication_usecase.dart';
import 'features/authentication/external/firebase_authentication_datasource.dart';
import 'features/authentication/presentation/cubit/login_cubit.dart';
import 'features/authentication/presentation/pages/create_account_page.dart';
import 'features/main/presentation/pages/logged_page.dart';
import 'features/authentication/presentation/pages/login_page.dart';

class AppModule extends Module {

  AppModule();

  @override
  void binds(i) {
    i.addInstance<IFirebaseAuthenticationDatasource>(FirebaseAuthenticationDatasource());
    i.addInstance<IFirebaseAuthenticationRepository>(FirebaseAuthenticationRepository());
    i.addInstance<IFirebaseAuthenticationUsecase>(FirebaseAuthenticationUsecase());
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => BlocProvider(
        create: (_) => LoginCubit(),
        child: LoginPage(),
      ),);
    r.child(CreateAccountPage.route,
        child: (_) => BlocProvider(
        create: (_) => LoginCubit(),
        child: CreateAccountPage(),
      ),);
    r.child(LoggedPage.route, child: ((_) => LoggedPage()));
  }
}
