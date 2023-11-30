import 'package:e_shoping/home_Page.dart';
import 'package:e_shoping/login_Page..dart'; // Corrected typo in file name
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
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Network available, proceed to check login status
      checkIfAlreadyLogin();
    } else {
      // No network, navigate to NetworkErrorPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NetworkErrorPage()),
      );
    }
  }

  Future<void> checkIfAlreadyLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Wait for some operation if needed before navigating
    await Future.delayed(Duration(seconds: 2));

    if (user != null) {
      // User is logged in, navigate to HomePage
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => homePage()));
      print('User is logged in');
    } else {
      // No user logged in, navigate to LoginPage
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/eshoping.png'),
      ),
    );
  }
}
