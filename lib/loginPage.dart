import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'dataAssisten.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Image.asset('assets/images/imageLogin.png'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 8.0) ,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextField(
                            controller: _username,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                size: 20,
                              ),
                              hintText: 'Username',
                              contentPadding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            )),
                        TextField(
                            obscureText: true,
                            controller: _pass,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                size: 20,
                              ),
                              hintText: 'Password',
                              contentPadding:
                                  const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                              margin: const EdgeInsets.only(top: 8.0) ,
                              child: Column(
                                children: [
                                  Text(
                                    "Lupa Password ?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextButton(
                      child: Text(
                        "Masuk".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffF3AB0D)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                      ),
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_username.text.isNotEmpty && _pass.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Future.delayed(Duration(seconds: 1), () {
        for (int id = 0; id < dataAssisten.length; id++) {
          if (_username.text == dataAssisten[id]["UserName"] &&
              _pass.text == dataAssisten[id]["PassWord"]) {
            String? fullname = dataAssisten[id]["FullName"] as String?;
            String? username = dataAssisten[id]["UserName"] as String?;
            prefs.setBool('user', true);
            prefs.setString('username', username!);
            prefs.setString('fullname', fullname!);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          }
        }
      });
    }
  }
}
