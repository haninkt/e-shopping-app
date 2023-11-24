import 'package:e_shoping/home_Page.dart';
import 'package:e_shoping/login_Page..dart';
import 'package:e_shoping/networkissu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
   _checkConnectivity();
  }
bool hasNetwork = false;

  void _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        hasNetwork = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => homePage()),
      );
    } else {
      setState(() {
        hasNetwork = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NetworkErrorPage()),
      );
    }
  }
  Future<void> checkIfAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    await Future.delayed(Duration(seconds: 2));
  if (user != null) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) =>homePage() ));
      print('safwan poliyaa');
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>LoginPage() ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/images/eshoping.png',
        ),
      ),
    );
  }
}


