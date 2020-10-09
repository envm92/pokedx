import 'package:flutter/material.dart';
import 'package:pokedx/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {

  final _loginFormKey = GlobalKey<FormState>();
  final _scaffoldFormKey = GlobalKey<ScaffoldState>();

  void login(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    if (_loginFormKey.currentState.validate()) {
      var authSrv = AuthService();
      authSrv.login().then((value) => Navigator.pushReplacementNamed(context, '/welcome'));
    } else {
      _scaffoldFormKey.currentState.showSnackBar(SnackBar(
        content: Text('Missing fields'),
      ));
    }
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
