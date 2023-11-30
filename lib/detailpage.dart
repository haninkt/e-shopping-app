import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shoping/cartlist.dart';
import 'package:e_shoping/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class detailpage extends StatefulWidget {
  const detailpage({super.key});

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  cartslistState cart = cartslistState();

  @override
  Widget build(BuildContext context) {
    final Api = Provider.of<api>(context);
    List<dynamic> images = [];
    images = Api.products[Api.productindex]['images'];
    // void addcart() {final data = {'name': '${Api.products[Api.productindex]['title']}', 'price': '\$${Api.products[Api.productindex]['price']}','thumbnail': '${Api.products[Api.productindex]['thumbnail']}'};
    // cart.likelist.add(data);}
    void addcart() {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final data = {
          'name': '${Api.products[Api.productindex]['title']}',
          'price': '\$${Api.products[Api.productindex]['price']}',
          'thumbnail': '${Api.products[Api.productindex]['thumbnail']}'
        };

        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cart')
            .add(data);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            hintText: "Search hear",
            prefixIcon: const Icon(Icons.search,
                color: Color.fromARGB(216, 139, 137, 137)),
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic,
                    color: Color.fromARGB(216, 139, 137, 137))),
            filled: true,
            fillColor: Color.fromARGB(255, 238, 238, 238),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(167, 1, 201, 236),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                for (var i = 0;
                    i < Api.products[Api.productindex]["images"].length;
                    i++)
                  Image.network(images[i])
              ],
              options: CarouselOptions(
                height: 300.0,
                autoPlay: true,
                viewportFraction: 1.0,
                initialPage: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(Api.products[Api.productindex]['description']),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '\$${Api.products[Api.productindex]['price']}',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addcart();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Added to Cart')));
                    Vibration.vibrate(duration: 500);
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
