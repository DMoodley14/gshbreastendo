import 'package:flutter/material.dart';

import './form.dart';

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Container(child: Text("Something went wrong")));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Loading"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/pink3.jpg"),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 200,
                        child: Container(
                          height: 100,
                          child: Text(
                            'Groote Schuur Hospital Breast and Endocrine Unit Bookings',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ));
  }
}

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignupForm();
  }
}
