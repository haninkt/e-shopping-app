import 'package:e_shoping/login_Page..dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late User? _user;
  void initState() {
    super.initState();

    _fetchUserData();
  }


  Future<void> signOutGoogle() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // Sign out from Firebase
      await _auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print("Error occurred during sign-out: $e");
    }
  }


  Future<void> _fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    _user = auth.currentUser;
    // setState(() {}); // Update the UI after fetching user data
}
  
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final String? photoUrl = user?.photoURL;
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage:  photoUrl != null
                                    ? NetworkImage(photoUrl)
                                    : AssetImage('assets/user pic.jpg')
                                        as ImageProvider,  
                    backgroundColor: Colors.transparent,
                  ),
                  // CircleAvatar(radius: 50,

                  //   child:Image(image: NetworkImage(user?.photoURL ??''),fit:BoxFit.fill ,)
                  // galleryFile == null
                  //     ? const Center(child: Text('Sorry nothing selected!!'))
                  //     : Center(
                  //         child: Image.file(galleryFile!),
                  //         ),

                  Positioned(
                    bottom: 0.0,
                    right: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context: context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          )),
                    ),
                  )
                ],
              ),
              // SizedBox(
              //   height: 100,
              //   width: 100,
              //   child: CircleAvatar(
              //       radius: 50,
              //       backgroundImage: AssetImage("assets/user pic.jpg"),
              //       child: SizedBox()),
              // ),
              SizedBox(
                height: 10,
              ),
             Text(
                               user != null ? '${_user!.displayName}' : '',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                                Text(
                               user != null ? '${_user!.email}' : '',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
              SizedBox(
                height: 10,
              ),
              Column(children: [
                Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color:Colors.black,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Icon(Icons.privacy_tip , color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Container(
                            child: Text(
                          'privacy',
                          style: TextStyle(fontSize: 20,color: Colors.white ),
                        )),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Icon(Icons.help_center, color: Colors.white),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                            child: Text(
                          'help & support',
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        )),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color:Colors.black,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Icon(Icons.settings, color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        GestureDetector(
                          onTap: () {
                          
                          },
                          child: Container(
                              child: Text(
                            'settings',
                            style: TextStyle(fontSize: 20,color: Colors.white),
                          )),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    exitapp();
                  },
                  child: Container(
                      width: 300,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.black,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Icon(Icons.logout , color: Colors.white),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Container(
                              child: Text(
                            'Logout',
                            style: TextStyle(fontSize: 20,color: Colors.white),
                          )),
                        ],
                      )),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> exitapp() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to exit this application?'),
          content: const SingleChildScrollView(),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('logout'),
              onPressed: () {
                signOutGoogle();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                },
              ),
            ],
          ),
        );
      },
    );
  }
}