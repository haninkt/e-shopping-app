
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
   final CollectionReference likelist = FirebaseFirestore.instance.collection('users');

  double totalPrice = 0;

  void deleteDonor(String docid) async {
  try {
    await likelist
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('wishlist')
        .doc(docid)
        .delete();
    print("Document with ID: $docid deleted");
  } catch (e) {
    print("Error deleting document: $e");
  }
}

  void calculateTotalPrice() {
    totalPrice = 0;
    likelist.doc(FirebaseAuth.instance.currentUser!.uid).collection('wishlist').get().then((snapshot) {
      for (DocumentSnapshot wishlist in snapshot.docs) {
        totalPrice += double.parse(wishlist['price']);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('wishlist',style: TextStyle(color: Colors.black)),
          elevation: 0.0,
          backgroundColor:  Colors.transparent,
        ),
        body: StreamBuilder(
          stream: likelist.doc(user.uid).collection('wishlist').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
  calculateTotalPrice();
  return ListView.builder(
    itemCount: snapshot.data?.docs.length,
    itemBuilder: (context, index) {
      final DocumentSnapshot wishlist = snapshot.data!.docs[index];
      return ListTile(
        leading: SizedBox(
          height: 115,
          width: 100,
          child: Image(
            image: NetworkImage(wishlist['thumbnail']),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(wishlist['name']),
        subtitle: Text(wishlist['price']),
        trailing: IconButton(
          onPressed: () {
            deleteDonor(wishlist.id);
          },
          icon: const Icon(Icons.delete),
        ),
      );
    },
  );
} else {
  return Center(
    child: Text('Empty'),
  );
}


            // return Center(
            //   child: LottieBuilder.asset('assets/images/Animation - 1700470091164.json'),
            // );
          },
        ),
      );
    } else {
      return Center(
        child: Text('Please login to view your cart'),
      );
    }
  }
}
