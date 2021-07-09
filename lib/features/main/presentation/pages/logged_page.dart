import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:social_network/features/authentication/domain/usecases/firebase_authentication_usecase.dart';

class LoggedPage extends StatefulWidget {
  static String route = "/logged";
  LoggedPage({Key key}) : super(key: key);

  @override
  _LoggedPageState createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Feed"),
        actions: [
          IconButton(
            tooltip: "Alterar senha",
            icon: Icon(Icons.lock),
            onPressed: () async {
              (await Modular.get<IFirebaseAuthenticationUsecase>()
                      .sendPasswordResetEmail("plucenio@hotmail.com"))
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
                  await ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text("Password changed"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      )
                      .closed;
                  Modular.to.pushReplacementNamed("/");
                },
              );
            },
          ),
          IconButton(
            tooltip: "Sair",
            icon: Icon(Icons.logout),
            onPressed: () async {
              (await Modular.get<IFirebaseAuthenticationUsecase>().signOut())
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
                  await ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Text("Logged out"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      )
                      .closed;
                  Modular.to.pushReplacementNamed("/");
                },
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Drawer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: Text("Nova postagem"),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    child: Text("Enfermaria"),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: Text("Oncologia"),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: Text("Neo-natal"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text("Teste"),
                        Text("Teste"),
                        Text("Teste"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
