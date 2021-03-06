import 'package:bloc_architecture_app/logic/cubit/login/login_cubit.dart';
import 'package:bloc_architecture_app/presentation/screens/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              child: Image.network(
                  'https://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png'),
            ),
            Center(
              child: const Text('Flutter on Back4App',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: controllerUsername,
              enabled: !isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Username'),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Password'),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: isLoggedIn ? null : () => doUserLogin(),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () => {Navigator.of(context).pushNamed('sign_up')},
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Reset Password'),
                onPressed: () =>
                    Navigator.of(context).pushNamed('reset_password'),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    var response = await BlocProvider.of<LoginCubit>(context)
        .loginUser(username, password);
    if (response == 'user_page') {
      Navigator.of(context).pushNamed(response);
    } else {
      Message.showError(context: context, message: response);
    }
  }
}
