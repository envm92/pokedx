import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {

  final _signUpFormKey = GlobalKey<FormState>();
  final _scaffoldFormKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthBloc _authBloc;

  void signUp(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    if (_signUpFormKey.currentState.validate()) {
      _authBloc.add(SignUpRequested( _emailController.text,
          _passwordController.text));
    } else {
      _showSnackBar('Missing fields');
    }
  }

  void _showSnackBar(String message) {
    _scaffoldFormKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Email'
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
                onPressed: () => signUp(context),
                child: Text('Sign Up!'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocBuilder() {
    return BlocBuilder<AuthBloc, AuthState> (
      cubit: _authBloc,
      builder: (BuildContext context, AuthState state) {
        if(state is RequestChangeState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildForm();
        }
      },
    );
  }

  void _blocListener(BuildContext context, AuthState state) {
    if(state is SignUpError) {
      _showSnackBar(state.message);
    }
    if(state is SignUpSuccess) {
      _showSnackBar('Thanks for sign in!');
      Navigator.pop(context, _emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldFormKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text('Sign Up'),
        ),
        body: BlocListener<AuthBloc, AuthState> (
          cubit: _authBloc,
          listener: _blocListener,
          child: _buildBlocBuilder(),
        )
    );
  }
}
