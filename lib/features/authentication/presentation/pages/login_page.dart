import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    var factor = 1.1;
    var sizeAnimation =
        SizeTween(begin: Size(400, 400), end: Size(400 * factor, 400 * factor))
            .animate(animationController);
    var sizeTextAnimation =
        Tween(begin: 1, end: factor).animate(animationController);
    var opacityAnimation =
        Tween(begin: 0.5, end: 0.8).animate(animationController);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Rede social corporativa"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: AnimatedBuilder(
                    animation: sizeAnimation,
                    builder: (context, snapshot) {
                      return AnimatedBuilder(
                        animation: opacityAnimation,
                        builder: (context, snapshot) {
                          return Opacity(
                            opacity: opacityAnimation.value,
                            child: Container(
                              child: Center(
                                child: Text(
                                  "Crie sua conta gratuitamente!",
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .fontSize *
                                          sizeTextAnimation.value),
                                ),
                              ),
                              height: sizeAnimation.value.height,
                              width: sizeAnimation.value.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.white70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BlocConsumer<LoginCubit, LoginState>(
                          listener: (context, state) {
                        if (state is ErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (state is LoadedState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        if (state is LoadingState) {
                          return Text('Loading');
                        }
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                validator: (String value) {
                                  return value.isEmpty ||
                                          (!value.contains('@') ||
                                              !value.contains('.com'))
                                      ? 'Email inválido'
                                      : null;
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: 'Senha',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  child: Text("Entrar"),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      context.read<LoginCubit>().signIn(
                                          emailController.text,
                                          passwordController.text);
                                    }
                                  }),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  Modular.to.pushNamed(CreateAccountPage.route);
                                },
                                child: Text("Criar conta"),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    if (_formKey.currentState.validate()) {
                                      context
                                          .read<LoginCubit>()
                                          .forget(emailController.text);
                                    }
                                  }
                                },
                                child: Text("Esqueci minha senha"),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
