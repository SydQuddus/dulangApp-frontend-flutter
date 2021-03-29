
import 'package:dulang_new/models/profile.dart';
import 'package:dulang_new/shared/styles.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dulang_new/pages/home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String emailInput, nameInput, locationInput, passwordInput;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter email');
        }
      },
      decoration: InputDecoration(
          labelText: 'ENTER EMAIL',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      onSaved: (input) => emailInput = input,
    );

    final nameField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter name');
        }
      },
      decoration: InputDecoration(
          labelText: 'ENTER NAME',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      onSaved: (input) => nameInput = input,
    );

    final locationField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter location');
        }
      },
      decoration: InputDecoration(
          labelText: 'ENTER LOCATION',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      onSaved: (input) => locationInput = input,
    );

    final passwordField = TextFormField(
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return ('Please enter password');
        } else if (input.length < 6) {
          return ('password must be above 6 characters');
        }
      },
      decoration: InputDecoration(
          labelText: 'CREATE PASSWORD',
          labelStyle: greyBoldText,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(247, 178, 167, 1)))),
      obscureText: true,
      onSaved: (input) => passwordInput = input,
    );

    final signupButton = Container(
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Color.fromRGBO(247, 178, 167, 5),
        color: Color.fromRGBO(247, 178, 167, 1),
        elevation: 7.0,
        child: InkWell(
          onTap: signUp,
          child: Center(
            child: Text(
              'SIGNUP',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );

    final backButton = Container(
      height: 40.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, style: BorderStyle.solid, width: 1.0),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text('Go Back',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
          ),
        ),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                              child: Text(
                                '.',
                                style: TextStyle(
                                    fontSize: 80.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(247, 178, 167, 1)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      emailField,
                      SizedBox(height: 20.0),
                      nameField,
                      SizedBox(height: 20.0),
                      locationField,
                      SizedBox(height: 20.0),
                      passwordField,
                      SizedBox(height: 20.0),
                      signupButton,
                      SizedBox(height: 20.0),
                      backButton
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailInput, password: passwordInput))
            .user;

        //Update user data
        final CollectionReference postsRef =
            Firestore.instance.collection('/users');

        var profileID = user.uid;

        Profile profile = new Profile(
            id: profileID,
            name: nameInput,
            location: locationInput,
            distance: "0.5",
            imageUrl: null,
            imageFileName: null);
        Map<String, dynamic> profileData = profile.toJson();
        await postsRef.document(profileID).setData(profileData);

        //user.sendEmailVerification();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(user: user.uid.toString(), tab: 0)));
        awesomeToast('Successfully registered');
      } catch (e) {
        print('Registration failed');
        awesomeToast('Registration failed');
      }
    }
  }
}
