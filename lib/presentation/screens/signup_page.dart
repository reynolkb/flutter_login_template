import 'package:bloc_architecture_app/logic/cubit/signup/signup_cubit.dart';
import 'package:bloc_architecture_app/presentation/screens/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Sign Up'),
        ),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: const Text('User registration',
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
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
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'E-mail'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
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
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () => doUserRegistration(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    var response = await BlocProvider.of<SignupCubit>(context)
        .signupUser(username, password, email);

    if (response ==
        'User was successfully created! Please verify your email before Login') {
      Message.showSuccess(
          context: context,
          message: response,
          onPressed: () async {
            Navigator.pop(context);
          });
    } else {
      Message.showError(context: context, message: response);
    }
  }
}
