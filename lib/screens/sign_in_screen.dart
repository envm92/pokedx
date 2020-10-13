import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';
import 'package:pokedx/models/user.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final _scaffoldFormKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthBloc _authBloc;

  void signIn(BuildContext context) {
    FocusManager.instance.primaryFocus.unfocus();
    if (_signInFormKey.currentState.validate()) {
      _authBloc.add(SignInRequested(
          user: User('', _emailController.text),
          password: _passwordController.text));
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
          key: _signInFormKey,
          child: Column(
            children: [
              TextFormField(
                  key: Key('emailSignIn'),
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(), hintText: 'UserName'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  }),
              SizedBox(height: 20),
              TextFormField(
                key: Key('passwordSignIn'),
                controller: _passwordController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(), hintText: 'Password'),
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
                onPressed: () => signIn(context),
                child: Text('Sign In'),
              ),
              SizedBox(height: 20),
              FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                  child: Text('Don\'t have any account? Sign up!'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocBuilder() {
    return BlocBuilder<AuthBloc, AuthState>(
      cubit: _authBloc,
      builder: (BuildContext context, AuthState state) {
        if (state is RequestChangeState) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildForm();
        }
      },
    );
  }

  void _blocListener(BuildContext context, AuthState state) {
    if (state is ErrorState) {
      _showSnackBar(state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldFormKey,
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          cubit: _authBloc,
          listener: _blocListener,
          child: _buildBlocBuilder(),
        ));
  }
}
