import 'package:e_shoping/detailpage.dart';
import 'package:e_shoping/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  List<dynamic> filteredProducts = [];

  void filterProducts(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredProducts =
          Provider.of<api>(context, listen: false).products.where((product) {
        return product['title'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            onChanged: filterProducts,
            decoration: InputDecoration(
              hintText: 'Search Items',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final item = filteredProducts[index];
                if (searchText.isEmpty ||
                    item.toLowerCase().contains(searchText.toLowerCase())) {
                  return ListTile(
                    onTap: () { index = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => detailpage()));},
                    title: Text('${filteredProducts[index]['title']}',
                        style: const TextStyle(fontSize: 13.0)),
                    leading: Image.network(
                        '${filteredProducts[index]['thumbnail']}',
                        height: 99.0,
                        width: 100),
                    trailing: Text('\$${filteredProducts[index]['price']}',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
