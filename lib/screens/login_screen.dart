import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldFormKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthBloc _authBloc;

  void login(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    if (_loginFormKey.currentState.validate()) {
      _authBloc.authRepository.signIn(_emailController.text, _passwordController.text);
    } else {
      _scaffoldFormKey.currentState.showSnackBar(SnackBar(
        content: Text('Missing fields'),
      ));
    }
  }


  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldFormKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'UserName'
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    }
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Password'
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => login(context),
                  child: Text('Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
