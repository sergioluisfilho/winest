import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:winest/HomePage.dart';
import 'package:winest/sign_in/login_services.dart';
import 'package:winest/sign_up/sign_up.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var uid = "";
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  bool showPassword = false;

  TextEditingController _mailInputController = TextEditingController();
  TextEditingController _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(92, 17, 94, 2),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
              ),
              Image.asset('images/logo.png'),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.length < 5) {
                            return "This email is too short";
                          } else if (!value.contains("@")) {
                            return "That email looks a little weird, doesn't it?";
                          }
                          return null;
                        },
                        controller: _mailInputController,
                        autofocus: false,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.length < 6) {
                            return "The password must contain at least 6 caracthers";
                          }
                          return null;
                        },
                        controller: _passwordInputController,
                        obscureText: (this.showPassword == true) ? false : true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          prefixIcon: Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(92, 17, 94, 2),
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                    ),
                    Container(),
                    Row(
                      children: [
                        Checkbox(
                          value: this.showPassword,
                          onChanged: (bool newValue) {
                            setState(() {
                              this.showPassword = newValue;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        Text(
                          "Show Password",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _doSignIn();
                },
                child: Text("Login"),
                color: Color.fromRGBO(255, 223, 43, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (contex) => SignUpPage()));
                  });
                },
                child: Text("Register"),
                color: Color.fromRGBO(255, 223, 43, 51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(width: 0, height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _doSignIn() async {
    if (_formKey.currentState.validate()) {
      uid = await LoginService().login(
        _mailInputController.text,
        _passwordInputController.text,
      );

      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (contex) => HomePage(uid)));
      //se der tudo certo de um set state com _isLoggedIn = true e set o user_data e de um pushreplacement
    } else {
      print("Invalid");
    }
  }
}
