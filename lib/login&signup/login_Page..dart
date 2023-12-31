import 'package:e_shoping/home_Page.dart';
import 'package:e_shoping/login&signup/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:vibration/vibration.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool eyehide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 100.0),
              LottieBuilder.asset(
                  'assets/images/Animation - 1700807557881.json'),
              SizedBox(
                  width: 270.0,
                  height: 50.0,
                  child: TextField(
                    controller:
                        _emailController, // Use this controller for email
                    keyboardType: TextInputType
                        .emailAddress, // Set keyboard type to email input
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                  )),
              SizedBox(height: 30.0),
              SizedBox(
                  width: 270.0,
                  height: 50.0,
                  child: TextField(
                    controller:
                        _passwordController, // Use this controller for password
                    obscureText: eyehide,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          eyehide ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            eyehide = !eyehide;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                  )),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text
                      .trim(); // Get text from email controller and trim whitespaces
                  String password = _passwordController.text
                      .trim(); // Get text from password controller and trim whitespaces

                  if (email.isNotEmpty && password.isNotEmpty) {
                    _loginWithEmailAndPassword(email,
                        password); // Call this method when button is pressed with provided credentials.
                  } else {
                    print('Please enter both an email and a password.');
                  }
                },
                child: Text('Login'),
              ),
              SignInButton(
                Buttons.google,
                onPressed: () async {
                  UserCredential? userCredential = await signInWithGoogle();
                  if (userCredential != true) {
                    // Successful sign-in msp]
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => homePage()));
                        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('login successfully'),
        ),
      );
      Vibration.vibrate(duration: 300);
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }
                },
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have account?',
                      style: TextStyle(color: Colors.black)),
                  TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage()),
                            (Route<dynamic> route) => false);
                        //signup screen
                      },
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                      ))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
//msp
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// Inside the onPressed handler
  void _loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Login successful');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('login successfully'),
        ),
      );
      Vibration.vibrate(duration: 300);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
  }
}
