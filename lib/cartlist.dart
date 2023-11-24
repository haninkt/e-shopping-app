
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

class cartslistState extends State<cartslist> {
  final CollectionReference likelist = FirebaseFirestore.instance.collection('users');

  double totalPrice = 0;

  void deleteDonor(String docid) {
    likelist.doc(docid).delete();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    likelist.doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').get().then((snapshot) {
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
          title: Text('Cart List'),
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: likelist.doc(user.uid).collection('cart').snapshots(),
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
            }

            return Center(
              child: LottieBuilder.asset('assets/images/Animation - 1700470091164.json'),
            );
          },
        ),
        bottomNavigationBar: BottomBar(
          totalPrice: totalPrice,
          buyNow: () {
            // Handle the "Buy Now" button press here
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
}


class BottomBar extends StatefulWidget {
  final double totalPrice;
  final Function buyNow;

  const BottomBar({
    super.key,
    required this.totalPrice,
    required this.buyNow,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    final pay = Provider.of<razorpay>(context ,listen: false);
    return Container(
      height: 60,
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Total: \$${widget.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            onPressed:() {
              pay.oppensession(40000);
            },
            // razorpay().oppensession(100),
            
            child: const Text('Buy Now'),
          ),
        ],
      ),
    );
  }
}
