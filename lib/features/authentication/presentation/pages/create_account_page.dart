import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:social_network/features/authentication/domain/usecases/firebase_authentication_usecase.dart';

class CreateAccountPage extends StatefulWidget {
  static String route = "/create_account";
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: Card(
                  elevation: 0,
                  color: Colors.white70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: surnameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Sobrenome',
                              labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.always,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                            ),
                            validator: (String value) {
                              return value.length > 0 &&
                                      (!value.contains('@') ||
                                          !value.contains('.com'))
                                  ? 'Email inválido'
                                  : null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              (await Modular.get<
                                          IFirebaseAuthenticationUsecase>()
                                      .createUserWithEmailAndPassword(
                                          emailController.text,
                                          "temporary_password"))
                                  .fold(
                                (l) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l.message),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                (r) async {
                                  (await Modular.get<
                                              IFirebaseAuthenticationUsecase>()
                                          .sendPasswordResetEmail(r.user.email))
                                      .fold(
                                    (l) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(l.message),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    },
                                    (r) async {
                                      await ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Um link foi enviado para o seu email."),
                                              backgroundColor: Colors.green,
                                            ),
                                          )
                                          .closed;
                                      Modular.to.pushReplacementNamed("/");
                                    },
                                  );
                                },
                              );
                            },
                            child: Text("Criar conta"),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Modular.to.pushReplacementNamed(
                                "/",
                              );
                            },
                            child: Text("Voltar"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
