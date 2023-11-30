import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_shoping/dashbord.dart';
import 'package:flutter/material.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  

  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: currentindex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.favorite, size: 30),
            Icon(Icons.shopping_cart, size: 30),
            Icon(Icons.person, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: const Color.fromARGB(255, 189, 187, 187),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[currentindex]);
  }
  
 
}

