import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import './routes.dart';
import './pages.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailctrl = TextEditingController();
  final TextEditingController passwordctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: emailctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a valid email';
                          }
                          if (EmailValidator.validate(emailctrl.text.trim()) ==
                              false) {
                            return 'Please ensure that the email address provided is of correct format';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: passwordctrl,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 153, 204, 1),
                          Color.fromRGBO(255, 153, 204, .6),
                        ])),
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      onPressed: () async {
                        print(emailctrl.text);

                        try {
                          if (_formKey.currentState!.validate()) {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: emailctrl.text.trim(),
                              password: passwordctrl.text.trim(),
                            );

                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((var user) {
                              if (user == null) {
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeRoute2()));
                              }
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              'Error: Email address not registered!',
                              textAlign: TextAlign.center,
                            )));
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user!');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              'The password you have entered is incorrect!',
                              textAlign: TextAlign.center,
                            )));
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPass()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ElevatedButton(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Color.fromRGBO(255, 153, 204, 1),
                          Color.fromRGBO(10, 0, 100, 0.2),
                        ])),
                        child: Center(
                            child: Text(
                          "Create new account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  final _formKey2 = GlobalKey<FormState>();
  final TextEditingController titlectrl = TextEditingController();
  final TextEditingController surnamectrl = TextEditingController();
  final TextEditingController firstnamectrl = TextEditingController();
  final TextEditingController cellctrl = TextEditingController();
  final TextEditingController facilityctrl = TextEditingController();
  final TextEditingController regctrl = TextEditingController();
  final TextEditingController emailctrl = TextEditingController();
  final TextEditingController passwordctrl = TextEditingController();
  final TextEditingController passwordconctrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Signup"),
        backgroundColor: Colors.pink[100],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey2,
          child: Column(
            children: <Widget>[
              Container(
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/pink2.jpg"),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter)),
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 130,
                      child: Container(
                        height: 10,
                        child: Text(
                          'Welcome to Groote Schuur Hospital Breast and Endocrine Unit Bookings!\n Please complete the form below:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: titlectrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: surnamectrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Surname",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your surname';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: firstnamectrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "First name",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: cellctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Cellphone number",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your cell number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: facilityctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.local_hospital_rounded,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Referring Hospital/Clinic/Practice",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your facility name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: regctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.medical_services,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "HPCSA / SANC number",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter your reg number';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: emailctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a valid email';
                          }
                          if (EmailValidator.validate(emailctrl.text.trim()) ==
                              false) {
                            return 'Please ensure that the email provided is correct';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: passwordctrl,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter some text';
                          }
                          if (passwordctrl.text.trim().length < 8) {
                            return 'Please ensure your password is at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: passwordconctrl,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter some text';
                          }
                          if (passwordconctrl.text.trim() !=
                              passwordctrl.text.trim()) {
                            print("d");
                            return 'Please re-enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color.fromRGBO(255, 153, 204, 1),
                            Color.fromRGBO(10, 0, 100, 0.2),
                          ])),
                          child: Center(
                              child: Text(
                            "Create new account",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                        onPressed: () async {
                          if (_formKey2.currentState!.validate()) {
                            showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Account Creation'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'By tapping accept, the user acknowledges and agrees to the terms of use and privacy policy which are available on www.gshbreastendocrine.co.za'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'Decline',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()),
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Accept'),
                                        onPressed: () async {
                                          try {
                                            UserCredential userCredential =
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                              email: emailctrl.text.trim(),
                                              password:
                                                  passwordctrl.text.trim(),
                                            );
                                            var user = FirebaseAuth
                                                .instance.currentUser;
                                            if (!user!.emailVerified) {
                                              print("not verified");
                                              await user
                                                  .sendEmailVerification();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Progress()));
                                            }
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'weak-password') {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: new Text(
                                                    'Error! Password should be at least six characters.'),
                                                duration: Duration(seconds: 3),
                                              ));
                                            } else if (e.code ==
                                                'email-already-in-use') {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error: The email address that you have entered already has an account!'),
                                                duration: Duration(seconds: 3),
                                              ));
                                            }
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                });
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UProfile extends StatefulWidget {
  @override
  UProfileState createState() {
    return UProfileState();
  }
}

class UProfileState extends State<UProfile> {
  final _formKey2 = GlobalKey<UProfileState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.person,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.person,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "Surname",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.person,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "First name",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.phone,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "Cellphone number",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.local_hospital_rounded,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "Referring Hospital/Clinic/Practice",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(255, 153, 204, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(start: 0),
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.pink[100],
                                size: 18,
                              )),
                          border: InputBorder.none,
                          hintText: "HPCSA / SANC number",
                          hintStyle: TextStyle(color: Colors.grey[500])),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromRGBO(255, 153, 204, 1),
                        Color.fromRGBO(10, 0, 100, 0.2),
                      ])),
                      child: Center(
                          child: Text(
                        "Update Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeRoute2()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPass extends StatefulWidget {
  @override
  ForgotPassState createState() {
    return ForgotPassState();
  }
}

class ForgotPassState extends State<ForgotPass> {
  final _formKey3 = GlobalKey<ForgotPassState>();
  final TextEditingController emailctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        backgroundColor: Colors.pink[100],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey3,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromRGBO(255, 153, 204, .5),
                        Color.fromRGBO(255, 153, 204, 1),
                      ])),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Please enter your email address below. An email will be sent to that address with instructions on how to change your password.",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(255, 153, 204, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ]),
                      child: TextFormField(
                        controller: emailctrl,
                        decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsetsDirectional.only(start: 0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.pink[100],
                                  size: 18,
                                )),
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color.fromRGBO(255, 153, 204, 1),
                            Color.fromRGBO(10, 0, 100, 0.2),
                          ])),
                          child: Center(
                              child: Text(
                            "Proceed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailctrl.text.trim());
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: Text('Password Reset'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'If we have record of this email address, a link to reset password will be sent to your inbox. Click the link and enter a new password'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Proceed',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()),
                                        );
                                      },
                                    )
                                  ]);
                            },
                          );
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
