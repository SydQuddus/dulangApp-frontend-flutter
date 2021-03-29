import 'package:dulang_new/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dulang_new/shared/styles.dart';
import 'package:flutter/material.dart';

import 'package:dulang_new/pages/home.dart';
import 'package:dulang_new/pages/initialScreen/signup.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String emailInput, passwordInput;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter email');
        }
      },
      decoration: InputDecoration(
          labelText: 'EMAIL',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      onSaved: (input) => emailInput = input,
    );

    final passwordField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter password');
        }
      },
      decoration: InputDecoration(
          labelText: 'PASSWORD',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      obscureText: true,
      onSaved: (input) => passwordInput = input,
    );

    final loginButton = Container(
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Color.fromRGBO(247, 178, 167, 5),
        color: Color.fromRGBO(247, 178, 167, 1),
        elevation: 7.0,
        child: InkWell(
          onTap: signIn,
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Hello',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text('There',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                      child: Text('.',
                          style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(247, 178, 167, 1))),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    usernameField,
                    SizedBox(height: 20.0),
                    passwordField,
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15.0, left: 20.0),
                      child: InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color.fromRGBO(247, 178, 167, 1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    loginButton,
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to Dulang ?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Color.fromRGBO(247, 178, 167, 1),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailInput, password: passwordInput))
            .user;
        print('${user.uid.toString()}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(user: user.uid.toString(), tab: 0)));
        awesomeToast('Successfully logged in');
      } catch (e) {
        print('registrea');
        awesomeToast('wrong email or password');
      }
    }
  }
}
