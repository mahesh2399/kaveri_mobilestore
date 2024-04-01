import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaveri/login/bloc/login.service.dart';

import 'package:kaveri/login/bloc/login_bloc.dart';
import 'package:kaveri/login/bloc/login_event.dart';
import 'package:kaveri/login/bloc/login_state.dart';
import 'package:kaveri/category/presentation/category.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginService()),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Navigator.of(context).pushReplacementNamed('/home')  ;
          context.goNamed(CategoryScreen.routeName);
        } else if (state is LoginFailure) {
          // Display an error message if login fails
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text('Login failed: ${state.error}')));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            color: Colors.green.withOpacity(0.1),
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.center,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // Text(
                          //   'User Email',
                          // ),
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              // labelText: 'Username',
                              hintText: "Enter Your Email",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Text(
                          //   'Password',
                          // ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              // labelText: 'Password',
                              hintText: "Enter Your Password",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                //   BlocProvider.of<LoginBloc>(context).add(
                                //     LoginButtonPressed(
                                //       username: _usernameController.text,
                                //       password: _passwordController.text,
                                //     ),
                                //   );

                                if (_usernameController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill in all fields.'),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                          if (state is LoginLoading)
                            const SizedBox(
                                height: 20.0,
                                child: CircularProgressIndicator()),
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
