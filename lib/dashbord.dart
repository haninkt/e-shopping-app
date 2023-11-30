import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shoping/cartlist.dart';
import 'package:e_shoping/detailpage.dart';
import 'package:e_shoping/likelist.dart';
import 'package:e_shoping/profile.dart';
import 'package:e_shoping/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:e_shoping/serching.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:provider/provider.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final List data = [
    {
      "title": "Image 1",
      "url":
          "https://th.bing.com/th/id/R.556c5a8d29c1d0bc34b8767f224195a6?rik=0EiaPWQ9jWzG3w&riu=http%3a%2f%2fwww.sportmobile.co.uk%2fwp-content%2fuploads%2f2019%2f01%2fLatest-handsets-banner.png&ehk=PkFTYohIf7BnlMWPAXYT5%2fz8JIlw51M%2bgMOAMqyzq6M%3d&risl=&pid=ImgRaw&r=0"
    },
    {
      "title": "Image 2",
      "url":
          "https://i.pinimg.com/originals/ef/80/83/ef8083bfe79088dc00bd8eca9c821cd5.jpg"
    },
    {
      "title": "Image 3",
      "url":
          "https://cdn2.f-cdn.com/contestentries/1056441/23976434/595146d924172_thumb900.jpg"
    },
    {
      "title": "Image 4",
      "url": "https://s3.envato.com/files/273933420/Preview_Set/6.jpg"
    },
    {
      "title": "Image 5",
      "url":
          "https://thumbs.dreamstime.com/b/cosmetics-skin-care-gold-product-ads-purple-bottle-background-glittering-light-effect-vector-design-cosmetics-skin-care-187375894.jpg"
    },
    {
      "title": "Image 6",
      "url":
          "https://th.bing.com/th/id/R.ecba28e958cafefbd1bc20483c235ca7?rik=itjBaq4ra4iUkg&riu=http%3a%2f%2fwww.happyhomesindustries.com%2fuploads%2f4%2f0%2f5%2f2%2f40528873%2faccessories-banner_orig.jpg&ehk=ju2ZIN7hlApeHDkgoXuSVZgT%2bWNuUhNaKB%2ftNh%2bwWEk%3d&risl=&pid=ImgRaw&r=0"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      width: 450,
      height: double.infinity,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
            children: [
              Container(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.list,
                        size: 40,
                      ))),
              SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 200,
                  child: Image.asset('assets/images/eshoping.png'),
                ),
              ),
              SizedBox(
                width: 33,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          size: 35,
                        ))),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            width: 390,
            height: 70,
            child: GestureDetector(onTap: () {
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  SearchPage()),);
            },
              child: TextField(enableInteractiveSelection: false,enabled: false, 
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  hintText: "Search hear",
                  prefixIcon: const Icon(Icons.search,
                      color: Color.fromARGB(216, 139, 137, 137)),
                  // suffixIcon: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.mic,
                  //         color: Color.fromARGB(216, 139, 137, 137))),
                  filled: true,
                  fillColor: Color.fromARGB(255, 238, 238, 238),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 700),
                  height: MediaQuery.of(context).size.height /4,
                  viewportFraction: 1.0),
              items: data.map((item) {
                return GridTile(
                  footer: Container(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: Image.network(item["url"], fit: BoxFit.cover),
                );
              }).toList(),
            ),
            SizedBox(child: Text('PRODUCTS')),
            SizedBox(
              height: MediaQuery.of(context).size.height /2.31,
              width: double.infinity,
              child: Categories(),
            ),
          ],
        )
      ]),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final Api = Provider.of<api>(context);
    // List<dynamic> images = [];
    // images = Api.products[Api.productindex]['images'];
    // // void addcart() {final data = {'name': '${Api.products[Api.productindex]['title']}', 'price': '\$${Api.products[Api.productindex]['price']}','thumbnail': '${Api.products[Api.productindex]['thumbnail']}'};
    // // cart.likelist.add(data);}
    void addwish() {
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
            .collection('wishlist')
            .add(data);
      }
    }
    return Api.products.isNotEmpty
        ? GridView.builder(
          shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 230.0,
              // Set the height of each item
            ),
            itemCount: Api.products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Api.productindex = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => detailpage()),
                  );
                },
                child: GridTile(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.network('${Api.products[index]['thumbnail']}',
                            height: 99.0, width: double.infinity),
                        const SizedBox(height: 10.0),
                        Text('${Api.products[index]['title']}',
                            style: const TextStyle(fontSize: 13.0)),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            const Icon(Icons.star),
                            Text('${Api.products[index]['rating']}',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 50,
                            ),
                            Text('\$${Api.products[index]['price']}',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        IconButton(onPressed: () {addwish();
                          Vibration.vibrate(duration: 500);
                          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to Wishlist'),));
                        }, icon: Icon(Icons.favorite))
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : LottieBuilder.asset('assets/images/Animation - 1700470091164.json');
  }
}

var currentindex = 0;
final List<Widget> screens = [
  dashboard(),
  Likes(),
  cartslist(),
  ProfilePage(),
];
