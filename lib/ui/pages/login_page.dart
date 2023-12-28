import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: 240,
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Theme.of(context).primaryColorLight,
                          Theme.of(context).primaryColorDark
                        ]),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                          blurRadius: 4,
                          color: Colors.black)
                    ],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(80))),
                child:
                    const Image(image: AssetImage('lib/ui/assets/logo.png'))),
            const Text('LOGIN'),
            Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Senha', icon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('ENTRAR')),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: const Text('CRIAR CONTA'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
