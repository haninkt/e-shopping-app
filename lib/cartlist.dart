import 'package:e_shoping/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class cartslist extends StatefulWidget {
  const cartslist({super.key});

  @override
  State<cartslist> createState() => cartslistState();
}
int totalPrice =0;
class cartslistState extends State<cartslist> {
  final CollectionReference cartlist =
      FirebaseFirestore.instance.collection('users');

  
    @override
   void initState() {
    super.initState();
    fetchTotalPrice(); // Call fetchTotalPrice method when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
 final Remove = Provider.of<deletion>(context);
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart List', style: TextStyle(color: Colors.black)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: StreamBuilder(
          stream: cartlist.doc(user.uid).collection('cart').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot cartlist = snapshot.data!.docs[index];
                  return ListTile(
                    leading: SizedBox(
                      height: 115,
                      width: 100,
                      child: Image(
                        image: NetworkImage(cartlist['thumbnail']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(cartlist['name']),
                    subtitle: Text(cartlist['price']),
                    trailing: IconButton(
                      onPressed: () {
                       Remove.deletecart;
                        
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              );
            }

            return Center(
              child: LottieBuilder.asset(
                  'assets/images/Animation - 1700470091164.json'),
            );
          },
        ),
//         bottomNavigationBar: BottomBar(

//   buyNow: () {
//     Provider.of<razorpay>(context, listen: false).oppensession(0);
//     // Handle "Buy Now" action here.
//     print('Buy now!');
//   },
// ),
 bottomNavigationBar: BottomBar(
  getTotalPrice: () => totalPrice, // Pass totalPrice through a callback function
  buyNow: () {
   Provider.of<razorpay>(context, listen: false).oppensession(totalPrice);
    print('Buy now!');
  },
),
      );
    } else {
      return Center(
        child: Text('Please login to view your cart'),
      );
    }
  }
    void fetchTotalPrice() async {
    try {
      DocumentSnapshot<Object?> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> cartData = snapshot.data() as Map<String, dynamic>;
        int fetchedTotalPrice = cartData['totalPrice'] ?? 0.0;
        setState(() {
          totalPrice = fetchedTotalPrice;
        });
      }
    } catch (e) {
      print("Error fetching total price: $e");
}
}
}
      

class BottomBar extends StatelessWidget {
  final Function() getTotalPrice;
  final Function buyNow;

  const BottomBar({
    super.key,
    required this.getTotalPrice,
    required this.buyNow,
  });

  @override
  Widget build(BuildContext context) {
    return 
       Container(
          height: 60,
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Total: \$$totalPrice',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () => buyNow(),
                child: const Text('Buy Now'),
              ),
            ],
          ),
        );
      }
  }
