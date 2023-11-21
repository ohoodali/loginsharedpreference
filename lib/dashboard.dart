import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String username;
  late String fullname;

  @override
  void initState() {
    super.initState();
    name();
  }

  void name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username')!;
      fullname = prefs.getString('fullname')!;
    });
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.setString('username', username);
    prefs.setString('fullname', fullname);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => Login()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xffF3AB0D),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.logout), onPressed: _logOut)
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Hai, Selamat Datang",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Image.asset('assets/images/imageDashboard.png'),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.5,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF3AB0D),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  )),
                              height: 10,
                              width: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Text(
                            "$fullname",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "$username",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
