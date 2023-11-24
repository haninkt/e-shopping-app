import 'package:e_shoping/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NetworkErrorPage extends StatelessWidget {
  const NetworkErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset('assets/images/Kz1Cl51GXh.json'),
            const Text(
              'Network Error',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
