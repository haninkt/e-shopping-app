
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
  final CollectionReference cartlist = FirebaseFirestore.instance.collection('users');
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
  }

  void deletecart(String docid) async {
    try {
      await cartlist
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cart')
          .doc(docid)
          .delete();
      print("Document with ID: $docid deleted");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }

  void fetchCartItemsAndCalculateTotalPrice(BuildContext context) async {
    double newTotalPrice = 0;
    QuerySnapshot snapshot = await cartlist.doc(FirebaseAuth.instance.currentUser!.uid).collection('cart').get();

    for (DocumentSnapshot doc in snapshot.docs) {
      newTotalPrice += double.tryParse(doc['price'].toString()) ?? 0;
    }

    setState(() {
      totalPrice = newTotalPrice;
    });

    context.read<CartProvider>().setTotalPrice(newTotalPrice);
}

  void saveTotalPriceToFirebase(double totalPrice) async {
    try {
      await cartlist.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'totalPrice': totalPrice,
      });
      print("Total price updated in Firebase");
    } catch (e) {
      print("Error saving total price: $e");
    }
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
                        deletecart(cartlist.id);
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
  getTotalPrice: () => totalPrice, // Pass totalPrice through a callback function
  buyNow: () {
    // Handle "Buy Now" action here.
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
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Container(
          height: 60,
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
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
      },
    );
  }
}