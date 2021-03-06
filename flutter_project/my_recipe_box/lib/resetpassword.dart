import 'package:flutter/material.dart';
import 'package:my_recipe_box/forgotpasswordpage.dart';
import 'package:my_recipe_box/login.dart';
import 'package:http/http.dart';
import 'package:window_location_href/window_location_href.dart';

final href = getHref();
String str = href.toString();
var arr = str.split('/');
final String token = arr[arr.length - 1];

//void main() => runApp(Register());

class ResetPassword extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration UI',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a green toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Reset Password Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final createUrl = 'https://www.myrecipebox.club/api/users/api/users/forgotPassword/' + token;
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmationController = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'OpenSans', fontSize: 20.0);

  Future<void> _emailDialog(String title, String message, bool success) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Exit'),
              onPressed: () {
                if (success) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }
                else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final registration = Text(
      'Create a new password.',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
    );
    final passwordField = TextField(
      obscureText: false,
      style: style,
      controller: passwordController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordConfirmationField = TextField(
      obscureText: false,
      style: style,
      controller: passwordConfirmationController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff4caf50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var response = await patch(createUrl,
              headers: {'Content-type': 'application/json'},
              body: {'password': passwordController.text,
              'passwordConfirm': passwordConfirmationController.text});
          print(response.statusCode);
          String title;
          String message;
          bool success;
          if (response.statusCode == 200) {
            title = "Success";
            message = "Password confirmation successful. Please login.";
            success = true;
          }
          else {
            title = "Error";
            message = "Invalid entry or password reset service expired.";
            success = false;
          }
          _emailDialog(title, message, success);
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          );*/
        },
        child: Text("Send Email",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          color: Colors.green[50],
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 5.0),
                registration,
                SizedBox(height: 20.0),
                passwordField,
                SizedBox(height: 10.0),
                passwordConfirmationField,
                SizedBox(height: 10.0),
                submitButton,
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


