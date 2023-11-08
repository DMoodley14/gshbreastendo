import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './form.dart';
import './pages.dart';

class BCRoute extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
              .startsWith('https://form.jotform.com/202111021719539')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://flutter.dev'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breast Clinic'),
        backgroundColor: Colors.pink[100],
      ),
      body: WebViewWidget(
        controller: WebViewController(),
      ),
    );
  }
}

class SETRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Surgical Endocrine/Thyroid Clinic'),
          backgroundColor: Colors.lightBlue[100],
        ),
        body: Text('')
        // WebView(
        //   initialUrl: 'https://form.jotform.com/202412122109538',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        );
  }
}

class SarRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sarcoma Clinic'),
          backgroundColor: Colors.purple,
        ),
        body: Text('') //WebView(
        // initialUrl: 'https://form.jotform.com/203081333924550',
        // javascriptMode: JavascriptMode.unrestricted,
        );
  }
}

class SettingRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
          ),
          backgroundColor: Colors.pink[100],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              /*ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.pink[300],
                ),
                title: Text("User Profile",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProf()),
                  );
                },
              ),
              Divider(),*/
              ListTile(
                  leading: Icon(
                    Icons.privacy_tip,
                    color: Colors.pink[300],
                  ),
                  title: Text("Privacy Policy",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  //onTap: () {
                  //Navigator.push(
                  // context,
                  // MaterialPageRoute(builder: (context) => PrivacyPol()),
                  //);
                  //},
                  onTap: () async {
                    if (await canLaunch(
                        "http://www.gshbreastendocrine.co.za/page-3.html")) {
                      await launch(
                          "http://www.gshbreastendocrine.co.za/page-3.html");
                    }
                  }),
              Divider()
            ],
          ),
        ));
  }
}

class CDRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        backgroundColor: Colors.pink[100],
      ),
      body: Column(
        children: [
          Image(image: AssetImage("assets/pink chair.jpg")),
          SizedBox(
            height: 40,
          ),
          Padding(
              padding: EdgeInsets.all(40),
              child: Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                            text:
                                "For more information please contact us on:\n",
                            style: TextStyle(
                                fontSize: 20,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none)),
                        TextSpan(
                            text: "breastsurgendo@gmail.com\n",
                            style: TextStyle(
                                fontSize: 20,
                                height: 2.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "http://www.gshbreastendocrine.co.za")) {
                                  await launch(
                                      "mailto:breastsurgendo@gmail.com?");
                                }
                                ;
                              }),
                        TextSpan(
                            text: "Or visit our website:\n",
                            style: TextStyle(
                                fontSize: 20,
                                height: 2.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none)),
                        TextSpan(
                            text: "www.gshbreastendocrine.co.za\n",
                            style: TextStyle(
                                fontSize: 20,
                                height: 2.5,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (await canLaunch(
                                    "http://www.gshbreastendocrine.co.za")) {
                                  await launch(
                                      "http://www.gshbreastendocrine.co.za");
                                }
                                ;
                              }),
                      ]),
                ),
              )),
        ],
      ),
    );
  }
}

class MammoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Routine Mammograms'),
        backgroundColor: Colors.blue,
      ),
      body: Text('')
      //WebView(
      // initialUrl: 'https://form.jotform.com/203180910939557',
      // javascriptMode: JavascriptMode.unrestricted,
      ,
    );
  }
}

class BCMPRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Breast Clinic MPH'),
          backgroundColor: Colors.pink[100],
        ),
        body: Text('')
        // WebView(
        //   initialUrl: 'https://form.jotform.com/203193842420550',
        //   javascriptMode: JavascriptMode.unrestricted,
        // ),
        );
  }
}

class UserProf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: Colors.pink[100],
        ),
        body: UProfile());
  }
}

class PrivacyPol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Privacy Policy'),
          backgroundColor: Colors.pink[100],
        ),
        body: Text('')
        // WebView(
        //   initialUrl: 'http://www.gshbreastendocrine.co.za/page-3.html',
        // ),
        );
  }
}

class HomeRoute2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 153, 204, 1),
        title: Container(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(child: Image(image: AssetImage('assets/GSH.jpg'))),
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromRGBO(255, 153, 204, .5),
                Color.fromRGBO(255, 153, 204, 1),
              ])),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Welcome to GSH Breast, Surgical Endocrine and Sarcoma Online Booking Portal!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  '''Before booking please read the following instructions below:''',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: ListTile(
                leading: Icon(
                  Icons.perm_device_info,
                  color: Colors.pink[300],
                  size: 30,
                ),
                title: Text(
                  '''To refer a patient to our unit, tap the menu icon on the top left, choose a clinic and follow the easy steps.''',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: ListTile(
                leading: Icon(
                  Icons.medical_services,
                  color: Colors.pink[300],
                  size: 30,
                ),
                title: Text(
                  '''Surgical emergencies are not to be referred through the app. All emergency referrals must be made by contacting the surgical registrar on call''',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: ListTile(
                leading: Icon(
                  Icons.no_cell,
                  color: Colors.pink[300],
                  size: 28,
                ),
                title: Text(
                  '''Your request may be rejected for the following reasons:
*  Inappropriate referrals i.e. Condition belongs to another speciality or sub speciality.
*  Incomplete information''',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: ListTile(
                leading: Icon(
                  Icons.support_agent,
                  color: Colors.pink[300],
                  size: 28,
                ),
                title: Text(
                  '''For more information visit our website:''',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black,
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(70, 0, 20, 0),
              child: ListTile(
                onTap: () async {
                  if (await canLaunch("http://www.gshbreastendocrine.co.za")) {
                    await launch("http://www.gshbreastendocrine.co.za");
                  }
                },
                title: Text(
                  '''www.gshbreastendocrine.co.za''',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.3,
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    decorationColor: Colors.black,
                  ),
                ),
              )),
        ],
      ),
      drawer: Drawer(
        child: Column(children: <Widget>[
          DrawerHeader(
            child: Text('GSH Breast, Surgical Endocrine and Sarcoma Unit',
                style: TextStyle(fontSize: 20)),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(255, 153, 204, .5),
              Color.fromRGBO(255, 153, 204, 1),
            ])),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.pink[300],
                  size: 24.0,
                ),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(
              Icons.date_range,
              color: Colors.pink[300],
              size: 24.0,
            ),
            title: Text('Bookings'),
            children: [
              ListTile(
                  title: Text('         Breast Clinic (GSH)'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BCRoute()));
                  }),
              ListTile(
                title: Text('''         Surgical Endocrine/Thyroid Clinic      
        (GSH)'''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SETRoute()),
                  );
                },
              ),
              ListTile(
                title: Text('         Sarcoma Clinic (GSH)'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SarRoute()),
                  );
                },
              ),
              ListTile(
                title: Text('         Routine Mammograms (GSH)'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MammoRoute()),
                  );
                },
              ),
              ListTile(
                title: Text('         Breast Clinic (MPH)'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BCMPRoute()),
                  );
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.perm_phone_msg,
              color: Colors.pink[300],
              size: 24.0,
            ),
            title: Text('Contact Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CDRoute()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_settings_alt,
              color: Colors.pink[300],
              size: 24.0,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingRoute()),
              );
            },
          ),
          Expanded(
              child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              onTap: () async {
                if (await canLaunch("http://www.ivline.co.za")) {
                  await launch("http://www.ivline.co.za");
                }
              },
              title: Text(
                """Developed by IV Line Apps\nwww.ivline.co.za""",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          )),
          Padding(padding: EdgeInsets.only(bottom: 20))
        ]),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromRGBO(255, 153, 204, .5),
            Color.fromRGBO(255, 153, 204, 1),
          ])),
      child: StreamBuilder(builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 7,
                  )),
            ],
          );
        }
        return AlertDialog(
            title: Text('Account Created Successfully'),
            content: Text(
                "Please remember to verify your email account with the link sent to your inbox."),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Proceed',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
              ),
            ]);
      }),
    ));
  }
}
